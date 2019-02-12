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
	@rm -rf build dist

requisites:
	@echo "Checking requisites" &&\
         which python &&\
         which pip &&\
         which pipenv || pip install --user pipenv
	@PYBASE=`python -m site --user-base` &&\
         echo "Python base directory: $$PYBASE" &&\
         [ -f $$PYBASE/bin/pipenv ] &&\
         PYVER=`python --version 2>&1 | awk '{ print substr($$2,1,3)}'` &&\
         echo "Python version: $$PYVER" &&\
         [ "$$PYVER" == "2.7" ] &&\
         echo "Requisites satisfied"

loadenv: requisites $(PIP_FILE)
	@echo "Environment loaded successfully"

$(PIP_FILE): $(PIP_REQ)
	@echo "Loading environment with pipenv" &&\
         PYBASE=`python -m site --user-base` &&\
         $$PYBASE/bin/pipenv install -r $(PIP_REQ)

$(SHOWQR_ICNS): $(SHOWQR_ICNS_RES)
	@echo "Making icon"
	@iconutil -c icns $(SHOWQR_ICNS_RES)

$(SHOWQR_FILE): loadenv $(SHOWQR_ICNS) $(SHOWQR_SRC)
	@echo "Generating ShowQR executable"
	@rm -rf dist
	@PYSITE=`python -m site --user-site` &&\
     PYBASE=`python -m site --user-base` &&\
         $$PYBASE/bin/pipenv run pyinstaller\
                     --onefile\
                     --icon $(SHOWQR_ICNS)\
                     -s\
                     -c\
                     -F\
                     -p $$PYSITE\
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
         echo "Testing ShowQR" | $(SHOWQR_FILE)

install: showqr $(SHOWQR_WORKFLOW)
	@echo "Installing ShowQR" &&\
         mkdir -p $$HOMEBREW_FORMULA_PREFIX/bin &&\
	 cp $(SHOWQR_FILE) $$HOMEBREW_FORMULA_PREFIX/bin/ &&\
	 cp -r $(SHOWQR_WORKFLOW) ~/Library/Services/ &&\
         echo "Installation successfully accomplished"

all: clean showqr install

