#
# ShowQR Makefile
#
PIP_FILE=Pipfile
PIP_REQ=requirements.txt
SHOWQR_SRC=showqr.py
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

requisites:
	@echo "Checking requisites" &&\
         which python &&\
         which pip &&\
         which pipenv &&\
         PYVER=`python --version 2>&1 | awk '{ print substr($$2,1,3)}'` &&\
         echo "Python version: $$PYVER" &&\
         [ "$$PYVER" == "2.7" ] &&\
         echo "Requisites satisfied"

loadenv: requisites $(PIP_FILE)
	@echo "Environment loaded successfully"

$(PIP_FILE): $(PIP_REQ)
	@echo "Loading environment with pipenv" &&\
         export LC_ALL=en_US.UTF-8 &&\
         export LANG=en_US.UTF-8 &&\
         pipenv --python=2.7 install -r $(PIP_REQ)

$(SHOWQR_ICNS): $(SHOWQR_ICNS_RES)
	@echo "Making icon"
	@iconutil -c icns $(SHOWQR_ICNS_RES)

$(SHOWQR_FILE): loadenv $(SHOWQR_ICNS) $(SHOWQR_SRC)
	@echo "Generating ShowQR executable"
	@rm -rf dist
	@export LC_ALL=en_US.UTF-8 &&\
         export LANG=en_US.UTF-8 &&\
         PYSITE=`python2 -m site --user-site` &&\
         pipenv run pyinstaller\
                     --onefile\
                     --icon $(SHOWQR_ICNS)\
                     -s\
                     -c\
                     -F\
                     -y\
                     $(SHOWQR_SRC)
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
	@echo "Installing ShowQR" &&\
         mkdir -p $$HOMEBREW_FORMULA_PREFIX/bin &&\
	 cp $(SHOWQR_FILE) $$HOMEBREW_FORMULA_PREFIX/bin/ &&\
	 cp -r $(SHOWQR_WORKFLOW) ~/Library/Services/ &&\
         echo "Installation successfully accomplished"

all: clean showqr install

