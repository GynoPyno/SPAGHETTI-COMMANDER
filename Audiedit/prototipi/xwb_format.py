import struct, os

# Minimal XACT XWB (WBND) wave-bank header parser to read per-wave format.
# Format ref: XACT2 wavebank. Header 'WBND', then segments. We read the
# WAVEBANKHEADER + WAVEBANKDATA + per-entry WAVEBANKENTRY.EntryFormat (dwFormat).

WAVEBANK_HEADER_SIGNATURE = b'WBND'

FMT_TAGS = {0:'PCM', 1:'XMA', 2:'ADPCM', 3:'WMA/xWMA'}

def parse_xwb(path, label):
    with open(path,'rb') as f:
        d = f.read()
    print(f"\n===== {label}\n  {path}\n  size={len(d)} magic={d[:4]!r}")
    if d[:4] != WAVEBANK_HEADER_SIGNATURE:
        print("  NOT a WBND file"); return
    ver, hver = struct.unpack_from('<II', d, 4)
    print(f"  version={ver} header_version={hver}")
    # 5 segments (Region: offset,length) start at 12 for v>=?
    # WAVEBANKHEADER: dwSignature(4) dwVersion(4) dwHeaderVersion(4) then WAVEBANKREGION Segments[5]
    off = 12
    segs = []
    for i in range(5):
        so, sl = struct.unpack_from('<II', d, off); off += 8
        segs.append((so,sl))
    names = ['BANKDATA','ENTRYMETADATA','SEEKTABLES','ENTRYNAMES','ENTRYWAVEDATA']
    for n,(so,sl) in zip(names,segs):
        print(f"    seg {n}: off={so} len={sl}")
    # WAVEBANKDATA at segs[0]
    bdo = segs[0][0]
    # struct WAVEBANKDATA: dwFlags(4) dwEntryCount(4) szBankName(64) dwEntryMetaDataElementSize(4)
    flags, entry_count = struct.unpack_from('<II', d, bdo)
    bank_name = d[bdo+8:bdo+8+64].split(b'\x00')[0].decode('ascii','replace')
    meta_elem_size, = struct.unpack_from('<I', d, bdo+8+64)
    print(f"  bank='{bank_name}' entries={entry_count} flags=0x{flags:08x} metaElemSize={meta_elem_size}")
    # Entry metadata array at segs[1]
    emo = segs[1][0]
    for i in range(entry_count):
        base = emo + i*meta_elem_size
        # WAVEBANKENTRY: dwFlagsAndDuration(4) Format(4) PlayRegion(off,len) LoopRegion(off,len)
        flags_dur, fmt = struct.unpack_from('<II', d, base)
        # decode Format dword (WAVEBANKMINIWAVEFORMAT):
        # bits: wFormatTag:2, nChannels:3, nSamplesPerSec:18, wBlockAlign:8, wBitsPerSample:1
        tag = fmt & 0x3
        channels = (fmt >> 2) & 0x7
        rate = (fmt >> 5) & 0x3FFFF
        block = (fmt >> 23) & 0xFF
        bits = (fmt >> 31) & 0x1
        print(f"    wave[{i}] tag={FMT_TAGS.get(tag,tag)} channels={channels} rate={rate} blockAlign={block} bits={'16' if bits else '8'}")

SND = r"C:\Program Files (x86)\Steam\steamapps\common\Supreme Commander Forged Alliance\sounds"
parse_xwb(SND + r"\Impacts.xwb", "VANILLA Impacts.xwb (attenuation works)")
parse_xwb(r"C:\Users\hp\Documents\My Games\Gas Powered Games\Supreme Commander Forged Alliance\mods\MemeSoundEffects\sounds\Memes.xwb", "MEME Memes.xwb (working mod)")
parse_xwb(r"C:\Users\hp\Documents\FAF_mod_cartella_lavoro_claude\audio_build\Audiowo.xwb", "OURS Audiowo.xwb")
