"""Catalogo completo del SupCom.xgs: categorie, variabili e curve RPC disponibili."""
import struct, os

SND = r"C:\Program Files (x86)\Steam\steamapps\common\Supreme Commander Forged Alliance\sounds"
g = open(os.path.join(SND, "SupCom.xgs"), 'rb').read()
u16 = lambda o: struct.unpack_from('<H', g, o)[0]
u32 = lambda o: struct.unpack_from('<I', g, o)[0]
f32 = lambda o: struct.unpack_from('<f', g, o)[0]

numCats = u16(19); numVars = u16(21); numRpc = u16(27)
catsOff = u32(33); varsOff = u32(37); catNamesOff = u32(57)
varNamesOff = u32(61); rpcOff = u32(65)
print(f"SupCom.xgs: {len(g)} byte | {numCats} categorie, {numVars} variabili, {numRpc} curve RPC")
print(f"  offset: categorie@{catsOff} variabili@{varsOff} nomiCat@{catNamesOff} "
      f"nomiVar@{varNamesOff} rpc@{rpcOff}")


def read_names(off, n):
    out = []; p = off
    for _ in range(n):
        e = g.index(b'\x00', p)
        out.append(g[p:e].decode('ascii', 'replace')); p = e + 1
    return out


cat_names = read_names(catNamesOff, numCats)
var_names = read_names(varNamesOff, numVars)

print(f"\n== CATEGORIE ({numCats}) ==")
for i in range(0, numCats, 4):
    print("   " + "  ".join(f"{j}:{cat_names[j]}" for j in range(i, min(i + 4, numCats))))

print(f"\n== VARIABILI ({numVars}) ==")
for i, nm in enumerate(var_names):
    b = varsOff + 13 * i
    print(f"   {i:>2} {nm:<28} init={f32(b+1):<12.2f} min={f32(b+5):<12.2f} max={f32(b+9):.2f}")

PARAM = {0: 'Volume', 1: 'Pitch', 2: 'ReverbSend', 3: 'FilterFreq', 4: 'FilterQ'}
print(f"\n== CURVE RPC ({numRpc}) -- il codice e' l'offset, da usare nel .xsb ==")
p = rpcOff
for i in range(numRpc):
    var = u16(p); npt = g[p + 2]; par = u16(p + 3)
    pts = []
    q = p + 5
    for _ in range(npt):
        pts.append((f32(q), f32(q + 4), g[q + 8])); q += 9
    vname = var_names[var] if var < len(var_names) else f"?{var}"
    print(f"\n   codice {p:<5} {vname} -> {PARAM.get(par, par)}   ({npt} punti)")
    for x, y, t in pts:
        unit = "dB" if par == 0 else ("cent" if par == 1 else "")
        print(f"        x={x:>10.1f}  y={y:>10.1f} {unit}")
    p = q
