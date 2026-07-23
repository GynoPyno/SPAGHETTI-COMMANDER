import struct, os

BUILD = r"C:\Users\hp\Documents\FAF_mod_cartella_lavoro_claude\audio_build"
SRC = os.path.join(BUILD, "Audiowo.xsb.working_backup")   # noto funzionante in game

d = open(SRC, 'rb').read()
u16 = lambda o: struct.unpack_from('<H', d, o)[0]
u32 = lambda o: struct.unpack_from('<I', d, o)[0]

print(f"filesize={len(d)}")
labels = ["simpleCues@34", "complexCues@38", "cueNames@42", "unk@46", "variationTables@50",
          "unk@54", "waveBankNames@58", "cueNameHashTable@62", "cueNameHashVals@66", "sounds@70"]
offs = {}
for i, lab in enumerate(labels):
    v = u32(34 + 4 * i)
    offs[lab] = v
    print(f"  {lab:22s} = {v}")
print(f"  numSounds={u16(28)} numSimpleCues={u16(19)} numTotalCues={u16(25)} numWaveBanks={d[27]}")

soundsOffset = u32(70)
names = ['acu_death', 'acu_upgrade_complete', 'nuke_alarm', 'mavor_impact']
print("\n== entry dei 4 sound (39 byte ciascuna) ==")
for i in range(4):
    b = soundsOffset + i * 39
    e = d[b:b + 39]
    flags = e[0]; cat = struct.unpack_from('<H', e, 1)[0]; nclips = e[9]
    clip = e[10:39]
    print(f"\n Sound[{i}] '{names[i]}' @{b} flags=0x{flags:02x} cat={cat} numClips={nclips}")
    print(f"   header : {e[:9].hex(' ')}")
    print(f"   clip29 : {clip.hex(' ')}")
    # cerca u32 che sembrano offset dentro il file
    cand = [(k, struct.unpack_from('<I', clip, k)[0]) for k in range(0, 29 - 3)]
    plaus = [(k, v) for k, v in cand if 0 < v < len(d)]
    print(f"   u32 plausibili come offset interni (pos_rel, valore): {plaus}")

print("\n== confronto: clip data del vanilla Impacts sound[0] ==")
vd = open(r"C:\Program Files (x86)\Steam\steamapps\common\Supreme Commander Forged Alliance\sounds\Impacts.xsb", 'rb').read()
vs = struct.unpack_from('<I', vd, 70)[0]
print("   vanilla clip inizia a rel 25 (dopo RPC 15b):", vd[vs + 25:vs + 25 + 29].hex(' '))

print("\n== regione dopo i sound ==")
sc = u32(34)
print(f"   fine sounds = {soundsOffset + 4*39}, simpleCuesOffset = {sc} -> gap = {sc - (soundsOffset + 4*39)}")
print("   simpleCues:", d[sc:sc + 20].hex(' '))
hv = u32(66)
print(f"   cueNameHashVals@{hv}:", d[hv:hv + 24].hex(' '))
cn = u32(42)
print(f"   cueNames@{cn}:", d[cn:cn + 70])
