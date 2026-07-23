import struct, os, collections

SND = r"C:\Program Files (x86)\Steam\steamapps\common\Supreme Commander Forged Alliance\sounds"
FMT = {0: 'PCM', 1: 'XMA', 2: 'ADPCM', 3: 'WMA'}


def rpc_starts():
    g = open(os.path.join(SND, "SupCom.xgs"), 'rb').read()
    n = struct.unpack_from('<H', g, 27)[0]
    p = 753; out = set()
    for _ in range(n):
        out.add(p); p += 5 + 9 * g[p + 2]
    return out


VALID_RPC = rpc_starts()


def bank_report(bank, cue):
    path = os.path.join(SND, bank + ".xsb")
    if not os.path.exists(path):
        print(f"  !! {path} non esiste"); return
    s = open(path, 'rb').read()
    u16 = lambda o: struct.unpack_from('<H', s, o)[0]
    u32 = lambda o: struct.unpack_from('<I', s, o)[0]
    numSimple = u16(19); numComplex = u16(21)
    simpleOff = u32(34); complexOff = u32(38); cueNames = u32(42); soundsOff = u32(70)
    names = [x.decode('ascii', 'replace') for x in s[cueNames:].split(b'\x00') if x]

    # fine della regione dei sound = primo offset di header maggiore di soundsOff
    others = [u32(34 + 4 * i) for i in range(10)]
    after = [v for v in others if v != 0xFFFFFFFF and v > soundsOff]
    soundsEnd = min(after) if after else len(s)

    def ok(so):
        return soundsOff <= so < soundsEnd and (s[so] & 0x01) == 0x01

    rec = None
    for r in range(8, 33):
        if complexOff == 0xFFFFFFFF or numComplex == 0:
            break
        if complexOff + r * numComplex > len(s):
            continue
        if all(ok(u32(complexOff + r * k + 1)) for k in range(numComplex)):
            rec = r; break

    entries = [u32(simpleOff + 5 * k + 1) for k in range(numSimple)]
    if rec:
        entries += [u32(complexOff + rec * k + 1) for k in range(numComplex)]

    print(f"\n  {bank}.xsb: {numSimple} simple + {numComplex} complex, recordComplex={rec}, "
          f"{len(names)} nomi")
    if cue not in names:
        print(f"  !! cue '{cue}' non trovata. Prime 12: {names[:12]}")
        return
    i = names.index(cue)
    if i >= len(entries):
        print(f"  !! indice cue {i} fuori dalla tabella ({len(entries)} voci)")
        return
    so = entries[i]
    flags = s[so]; cat = u16(so + 1); vol = s[so + 3]
    pitch = struct.unpack_from('<h', s, so + 4)[0]; prio = s[so + 6]
    q = so + 9; nclips = s[q]; q += 1
    rpc = []
    if flags & 0x0E:
        npr = s[q + 2]
        rpc = [u32(q + 3 + 4 * k) for k in range(npr)]
    valid = all(c in VALID_RPC for c in rpc) if rpc else None
    print(f"  cue '{cue}' -> sound @{so}")
    print(f"     flags=0x{flags:02x}  categoria={cat}  volume={vol}  pitch={pitch}  "
          f"priorita={prio}  numClips={nclips}")
    print(f"     RPC={rpc}  (codici validi: {valid})")


def wave_report(bank):
    path = os.path.join(SND, bank + ".xwb")
    if not os.path.exists(path):
        print(f"  !! {path} non esiste"); return
    d = open(path, 'rb').read()
    segs = [struct.unpack_from('<II', d, 12 + 8 * i) for i in range(5)]
    bdo = segs[0][0]
    entry_count = struct.unpack_from('<I', d, bdo + 4)[0]
    meta = struct.unpack_from('<I', d, bdo + 72)[0]
    emo = segs[1][0]
    combo = collections.Counter()
    for i in range(entry_count):
        fmt = struct.unpack_from('<I', d, emo + i * meta + 4)[0]
        combo[(FMT.get(fmt & 3, fmt & 3), (fmt >> 2) & 7, (fmt >> 5) & 0x3FFFF)] += 1
    print(f"  {bank}.xwb: {entry_count} onde, {os.path.getsize(path)} byte")
    for (tag, ch, rate), n in combo.most_common():
        print(f"     {n:>3} onde: {tag} {ch}ch {rate}Hz  {'<-- STEREO' if ch > 1 else ''}")


print("=" * 70)
print("ROTTO (non si attenua): XSA_Weapon / XSA0304_Zhanasse_Bomb")
print("=" * 70)
bank_report("XSA_Weapon", "XSA0304_Zhanasse_Bomb")
wave_report("XSA_Weapon")

print()
print("=" * 70)
print("FUNZIONANTE (si attenua): XSB_Weapon / XSB2303_Charge")
print("=" * 70)
bank_report("XSB_Weapon", "XSB2303_Charge")
wave_report("XSB_Weapon")

print()
print("=" * 70)
print("RIFERIMENTO: Impacts / Impact_Land_Gen_UEF_Big  (cue vanilla del Mavor)")
print("=" * 70)
bank_report("Impacts", "Impact_Land_Gen_UEF_Big")
wave_report("Impacts")

print()
print("=" * 70)
print("NOSTRO: Audiowo / mavor_impact")
print("=" * 70)
MOD = r"C:\Users\hp\Documents\My Games\Gas Powered Games\Supreme Commander Forged Alliance\mods\Audiowo\sounds"
wave_report_path = os.path.join(MOD, "Audiowo.xwb")
d = open(wave_report_path, 'rb').read()
segs = [struct.unpack_from('<II', d, 12 + 8 * i) for i in range(5)]
bdo = segs[0][0]
ec = struct.unpack_from('<I', d, bdo + 4)[0]
meta = struct.unpack_from('<I', d, bdo + 72)[0]
for i in range(ec):
    fmt = struct.unpack_from('<I', d, segs[1][0] + i * meta + 4)[0]
    print(f"     wave[{i}]: {FMT.get(fmt & 3)} {(fmt >> 2) & 7}ch {(fmt >> 5) & 0x3FFFF}Hz")
