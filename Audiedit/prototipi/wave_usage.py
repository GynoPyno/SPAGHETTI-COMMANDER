import struct, os, collections

SND = r"C:\Program Files (x86)\Steam\steamapps\common\Supreme Commander Forged Alliance\sounds"
s = open(os.path.join(SND, "Impacts.xsb"), 'rb').read()
u16 = lambda o: struct.unpack_from('<H', s, o)[0]
u32 = lambda o: struct.unpack_from('<I', s, o)[0]

numSimple = u16(19); numComplex = u16(21)
simpleOff = u32(34); complexOff = u32(38); cueNames = u32(42); soundsOff = u32(70)
names = [x.decode('ascii', 'replace') for x in s[cueNames:].split(b'\x00') if x]
cue_sound = [u32(simpleOff + 5 * k + 1) for k in range(numSimple)]
cue_sound += [u32(complexOff + 15 * k + 1) for k in range(numComplex)]


def waves_of(so):
    """restituisce la lista di indici onda usati dal sound (varianti incluse)"""
    q = so + 9
    nclips = s[q]; q += 1
    if s[so] & 0x0E:
        q += u16(q)                      # salta il blocco RPC
    if s[so] & 0x10:
        q += 7                           # salta il blocco DSP
    q += 1                               # clip volume
    clip = u32(q); q += 4
    assert clip == q, (clip, q)
    # clip data: 01 06 00 00 20 00 00 ff 0c + 12 byte + u16 count + u16 ? + ffffffff + N*5
    p = q + 9 + 12
    count = u16(p); p += 2
    p += 2 + 4                           # u16 sconosciuto + sentinella ffffffff
    out = []
    for _ in range(count):
        out.append(u16(p)); p += 5
    return out


usage = collections.defaultdict(list)
cue_waves = {}
for i, so in enumerate(cue_sound):
    nm = names[i] if i < len(names) else f"?{i}"
    try:
        w = waves_of(so)
    except Exception as e:
        w = f"errore: {e}"
        cue_waves[nm] = w
        continue
    cue_waves[nm] = w
    for x in w:
        usage[x].append(nm)

print(f"{'cue':<34} onde usate")
for nm, w in cue_waves.items():
    mark = "   <<< MAVOR" if nm == 'Impact_Land_Gen_UEF_Big' else ""
    print(f"  {nm:<32} {w}{mark}")

print("\nonde usate da UNA SOLA cue (candidate per una sostituzione pulita):")
solo = {w: c for w, c in usage.items() if len(c) == 1}
for w in sorted(solo):
    print(f"   onda {w:>2} -> solo '{solo[w][0]}'")

print("\ncue le cui onde sono TUTTE esclusive (dirottabili senza danni ad altre cue):")
for nm, w in cue_waves.items():
    if isinstance(w, list) and w and all(len(usage[x]) == 1 for x in w):
        print(f"   {nm}  onde={w}")
