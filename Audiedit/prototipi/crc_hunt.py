import struct, os

SND = r"C:\Program Files (x86)\Steam\steamapps\common\Supreme Commander Forged Alliance\sounds"
BUILD = r"C:\Users\hp\Documents\FAF_mod_cartella_lavoro_claude\audio_build"
MODS = r"C:\Users\hp\Documents\My Games\Gas Powered Games\Supreme Commander Forged Alliance\mods"

files = [
    os.path.join(SND, "Impacts.xsb"),
    os.path.join(SND, "Explosions.xsb"),
    os.path.join(SND, "UAAWeapon.xsb"),
    os.path.join(SND, "AmbientTest.xsb"),
    os.path.join(BUILD, "Audiowo.xsb"),                       # XactBld-compiled, works in game
    os.path.join(MODS, r"MemeSoundEffects\sounds\Memes.xsb"),  # 3rd-party mod, loads in game
]
samples = []
for f in files:
    if os.path.exists(f):
        d = open(f, 'rb').read()
        if d[:4] == b'SDBK':
            samples.append((os.path.basename(f), d, struct.unpack_from('<H', d, 8)[0]))
print("campioni:", [(n, hex(c), len(d)) for n, d, c in samples])

# ---- generic bitwise CRC16 ----
def crc16(data, poly, init, refin, refout, xorout):
    def rev8(b):
        b = ((b & 0xF0) >> 4) | ((b & 0x0F) << 4)
        b = ((b & 0xCC) >> 2) | ((b & 0x33) << 2)
        b = ((b & 0xAA) >> 1) | ((b & 0x55) << 1)
        return b
    def rev16(v):
        r = 0
        for _ in range(16):
            r = (r << 1) | (v & 1); v >>= 1
        return r
    crc = init
    for byte in data:
        if refin:
            byte = rev8(byte)
        crc ^= byte << 8
        for _ in range(8):
            crc = ((crc << 1) ^ poly) & 0xFFFF if (crc & 0x8000) else (crc << 1) & 0xFFFF
    if refout:
        crc = rev16(crc)
    return crc ^ xorout

# name, poly, init, refin, refout, xorout
VARIANTS = [
    ("CCITT-FALSE", 0x1021, 0xFFFF, False, False, 0x0000),
    ("XMODEM",      0x1021, 0x0000, False, False, 0x0000),
    ("AUG-CCITT",   0x1021, 0x1D0F, False, False, 0x0000),
    ("GENIBUS",     0x1021, 0xFFFF, False, False, 0xFFFF),
    ("KERMIT",      0x1021, 0x0000, True,  True,  0x0000),
    ("X-25",        0x1021, 0xFFFF, True,  True,  0xFFFF),
    ("MCRF4XX",     0x1021, 0xFFFF, True,  True,  0x0000),
    ("RIELLO",      0x1021, 0xB2AA, True,  True,  0x0000),
    ("TMS37157",    0x1021, 0x89EC, True,  True,  0x0000),
    ("A",           0x1021, 0xC6C6, True,  True,  0x0000),
    ("ARC",         0x8005, 0x0000, True,  True,  0x0000),
    ("MODBUS",      0x8005, 0xFFFF, True,  True,  0x0000),
    ("USB",         0x8005, 0xFFFF, True,  True,  0xFFFF),
    ("MAXIM",       0x8005, 0x0000, True,  True,  0xFFFF),
    ("BUYPASS",     0x8005, 0x0000, False, False, 0x0000),
    ("DDS-110",     0x8005, 0x800D, False, False, 0x0000),
    ("UMTS",        0x8005, 0x0000, False, False, 0x0000),
    ("CMS",         0x8005, 0xFFFF, False, False, 0x0000),
    ("DECT-R",      0x0589, 0x0000, False, False, 0x0001),
    ("DECT-X",      0x0589, 0x0000, False, False, 0x0000),
    ("DNP",         0x3D65, 0x0000, True,  True,  0xFFFF),
    ("EN13757",     0x3D65, 0x0000, False, False, 0xFFFF),
    ("T10-DIF",     0x8BB7, 0x0000, False, False, 0x0000),
    ("TELEDISK",    0xA097, 0x0000, False, False, 0x0000),
    ("CDMA2000",    0xC867, 0xFFFF, False, False, 0x0000),
]

def ranges(d):
    z = bytearray(d); z[8] = 0; z[9] = 0
    return {
        "whole_crc_zeroed": bytes(z),
        "whole_crc_skipped": d[:8] + d[10:],
        "from10_to_end": d[10:],
        "from4_crc_zeroed": bytes(z)[4:],
        "from12_to_end": d[12:],
        "header_only_zeroed": bytes(z)[:42],
        "after_header": d[42:],
    }

hits = []
for rname in ranges(samples[0][1]).keys():
    for vname, poly, init, refin, refout, xorout in VARIANTS:
        ok = all(crc16(ranges(d)[rname], poly, init, refin, refout, xorout) == c
                 for _, d, c in samples)
        if ok:
            hits.append((rname, vname))

print("\n== MATCH su TUTTI i campioni ==")
if hits:
    for h in hits:
        print("  ", h)
else:
    print("   nessuno")
    # diagnostica: il campo e' davvero variabile fra i file?
    print("\n   valori del campo @8:", [(n, hex(c)) for n, _, c in samples])
