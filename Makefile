#
# ShowQR Makefile
#
PYVER=3.8
PIP_FILE=Pipfile
PIP_REQ=requirements.txt
SHOWQR_SRC=showqr.py
SHOWQR_SPEC=showqr.spec
SHOWQR_FILE=dist/showqr
SHOWQR_ICNS_RES=ShowQR.iconset
SHOWQR_ICNS=showqr.icns
SHOWQR_WORKFLOW=ShowQR.workflow

usage:
	@echo "Usage:" &&\
         echo "    make clean   - Cleanup project folder" &&\
         echo "    make showqr  - Generate the showqr application" &&\
         echo "    make test    - Test the showqr executable" &&\
         echo "    make install - Install ShowQR (brew)"

clean:
	@rm -rf build dist *.spec *.png

$(PIP_FILE): $(PIP_REQ)
	@echo "Loading environment with pipenv" &&\
         export LC_ALL=en_US.UTF-8 &&\
         export LANG=en_US.UTF-8 &&\
         pipenv --python=$(PYVER) install -r $(PIP_REQ)

$(SHOWQR_ICNS): $(SHOWQR_ICNS_RES)
	@echo "Making icon"
	@iconutil -c icns $(SHOWQR_ICNS_RES)

$(SHOWQR_FILE): $(SHOWQR_ICNS) $(SHOWQR_SRC)
	@echo "Generating ShowQR executable"
	@rm -rf dist
	@export LC_ALL=en_US.UTF-8 
	@export LANG=en_US.UTF-8
	pipenv run pyinstaller\
                     --onefile\
                     --icon $(SHOWQR_ICNS)\
                     -s\
                     -c\
                     -F\
                     -y\
                     --exclude-module tcl\
                     --exclude-module tk\
                     --exclude-module _tkinter\
                     --exclude-module tkinter\
                     --exclude-module Tkinter\
                     $(SHOWQR_SRC)
	@mkdir -p dist
	@[ -f $(SHOWQR_FILE) ] &&\
           echo "Successfully created" ||\
           echo "Unsuccessfully created"

showqr: $(SHOWQR_FILE)
	@[ -f $(SHOWQR_FILE) ] &&\
           echo "ShowQR binary file at: " $(SHOWQR_FILE)

test: showqr
	@echo "Testing ShowQR" &&\
         echo "Testing ShowQR" | $(SHOWQR_FILE) -f &&\
         [ -f ShowQR.png ] &&\
         echo "QR code successfully created"

install: showqr $(SHOWQR_WORKFLOW)
	@echo "Installing ShowQR"
	@BREW_PFX=`brew --prefix` &&\
	 sudo cp $(SHOWQR_FILE) $$BREW_PFX/bin &&\
	 cp -r $(SHOWQR_WORKFLOW) ~/Library/Services/ &&\
         echo "Installation successfully accomplished"

all: clean showqr install

