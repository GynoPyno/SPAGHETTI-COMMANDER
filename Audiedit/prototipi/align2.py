"""Trova una combinazione di variabili/categorie/curve fittizie che porti l'offset
della curva RPC a 1050 nel .xgs generato da XactBld."""
import os, struct, shutil, subprocess

BUILD = r"C:\Users\hp\Documents\FAF_mod_cartella_lavoro_claude\audio_build"
XACTBLD = r"C:\Program Files (x86)\Microsoft DirectX SDK (August 2007)\Utilities\Bin\x86\XactBld.exe"
MOD = r"C:\Users\hp\Documents\My Games\Gas Powered Games\Supreme Commander Forged Alliance\mods\Audiowo\sounds"
BASE = os.path.join(BUILD, "Audiowo.xap.norpc_backup")
XAP = os.path.join(BUILD, "Audiowo.xap")
TARGET = 1050

VAR = """
    Variable
    {{
        Name = {name};
        Public = 1;
        Global = 0;
        Internal = 0;
        External = 0;
        Monitored = 1;
        Reserved = {res};
        Read Only = 0;
        Time = 0;
        Value = 0.000000;
        Initial Value = 0.000000;
        Min = 0.000000;
        Max = 1000000.000000;
    }}
"""

CAT = """
    Category
    {{
        Name = {name};
        Public = 1;
        Background Music = 0;
        Volume = 0;

        Category Entry
        {{
            Name = Global;
        }}

        Instance Limit
        {{
            Max Instances = 255;
            Behavior = 0;

            Crossfade
            {{
                Fade In = 0;
                Fade Out = 0;
                Crossfade Type = 0;
            }}
        }}
    }}
"""

RPC = """
    RPC
    {{
        Name = {name};

        RPC Curve
        {{
            Name = {name}Curve;
            Property = 0;
            Sound = 1;
            Line Color = 4278255360;
            Viewable = 1;

            Variable Entry
            {{
                Name = Distance;
            }}

            RPC Point
            {{
                X = 0.000000;
                Y = 0.000000;
                Curve = 0;
            }}

            RPC Point
            {{
                X = 10000.000000;
                Y = -9600.000000;
                Curve = 0;
            }}
        }}
    }}
"""

RPC_ENTRY = """
        RPC Entry
        {
            RPC Name = DistanceVolume;
        }
"""

src = open(BASE, 'r', encoding='utf-8', errors='replace').read()


def build(nvar=0, ncat=0, nrpc=0):
    blocks = ""
    for k in range(ncat):
        blocks += CAT.format(name=f"PadCat{k:03d}")
    blocks += VAR.format(name="Distance", res=1)
    for k in range(nvar):
        blocks += VAR.format(name=f"PadVar{k:03d}", res=0)
    for k in range(nrpc):
        blocks += RPC.format(name=f"PadRpc{k:03d}")
    blocks += RPC.format(name="DistanceVolume")
    i = src.index("\nWave Bank\n{")
    close = src.rindex("}", 0, i)
    out = src[:close] + blocks + src[close:]
    sb = out.index("\nSound Bank\n{")
    s_i = out.index("Name = mavor_impact;", sb)
    cat_end = out.index("}", out.index("Name = Default;", out.index("Category Entry", s_i))) + 1
    out = out[:cat_end] + RPC_ENTRY + out[cat_end:]
    assert out.count("RPC Entry") == 1
    open(XAP, 'w', encoding='utf-8').write(out)


def code_of():
    r = subprocess.run([XACTBLD, "/WIN32", "Audiowo.xap"], cwd=BUILD,
                       capture_output=True, text=True)
    if "Success" not in r.stdout:
        return None
    d = open(os.path.join(BUILD, "Audiowo.xsb"), 'rb').read()
    b = struct.unpack_from('<I', d, 70)[0] + 3 * 39
    if not d[b] & 0x02:
        return None
    return struct.unpack_from('<I', d, b + 10 + 3)[0]


print("misure:")
build(); c0 = code_of(); print(f"  base                 -> {c0}")
build(nvar=1); cv = code_of(); print(f"  +1 variabile         -> {cv}  (delta {cv - c0})")
build(ncat=1); cc = code_of(); print(f"  +1 categoria         -> {cc}  (delta {cc - c0})")
build(nrpc=1); cr = code_of(); print(f"  +1 curva RPC         -> {cr}  (delta {cr - c0})")

dv, dc, dr = cv - c0, cc - c0, cr - c0
need = TARGET - c0
print(f"\nservono {need} byte;  variabile={dv}  categoria={dc}  curva={dr}")

sol = None
for a in range(0, need // max(dv, 1) + 2):
    for b in range(0, (need // max(dc, 1)) + 2 if dc else 1):
        rest = need - a * dv - b * dc
        if rest < 0:
            continue
        if dr and rest % dr == 0:
            sol = (a, b, rest // dr)
            break
    if sol:
        break

print("combinazione trovata (variabili, categorie, curve extra):", sol)
if sol:
    build(nvar=sol[0], ncat=sol[1], nrpc=sol[2])
    got = code_of()
    print(f"verifica dopo compilazione: codice = {got}  {'OK' if got == TARGET else 'NON coincide'}")
    if got == TARGET:
        shutil.copy(os.path.join(BUILD, "Audiowo.xsb"), os.path.join(BUILD, "Audiowo_aligned.xsb"))
        shutil.copy(os.path.join(BUILD, "Audiowo.xsb"), os.path.join(MOD, "Audiowo.xsb"))
        shutil.copy(os.path.join(BUILD, "Audiowo.xgs"), os.path.join(MOD, "Audiowo.xgs"))
        print("deployato .xsb (+ .xgs coerente) nella mod, senza alcuna patch binaria")
