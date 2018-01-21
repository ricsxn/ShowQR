# -*- mode: python -*-

block_cipher = None


a = Analysis(['showqr.py'],
             pathex=['/Library/Python/2.7/site-packages', './venv/lib/python2.7/site-packages/', '/Users/riccardobruno/Documents/src/ShowQR'],
             binaries=[],
             datas=[],
             hiddenimports=[],
             hookspath=[],
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher)
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          a.binaries,
          a.zipfiles,
          a.datas,
          name='showqr',
          debug=False,
          strip=True,
          upx=True,
          runtime_tmpdir=None,
          console=True )
