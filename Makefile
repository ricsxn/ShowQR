#
# ShowQR Makefile
#
VENV_DIR=venv
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
         echo "    make install - Install ShowQR"

clean:
	@rm -rf build dist

requisites:
	@echo "Checking requisites" &&\
         which python &&\
         which pip &&\
         which virtualenv &&\
         PYVER=`python --version 2>&1 | awk '{ print substr($$2,1,3)}'` &&\
         echo "Python version: $$PYVER" &&\
         [ "$$PYVER" == "2.7" ] &&\
         echo "Requisites satisfied"

requirements: requisites $(PIP_REQ)
	@echo "Requirements"
	@[ ! -d "$(VENV_DIR)" ] &&\
           virtualenv $(VENV_DIR) ||\
           echo "Virtualenv directory already exists"
	@pip install -r $(PIP_REQ)		

loadenv: requirements
	@echo "Loading environment" 
	@. $(VENV_DIR)/bin/activate

$(SHOWQR_ICNS): $(SHOWQR_ICNS_RES)
	@echo "Making icon"
	@iconutil -c icns $(SHOWQR_ICNS)

showqr: loadenv $(SHOWQR_ICNS) $(SHOWQR_SRC)
	@echo "Generating ShowQR executable"
	@[ -d dist ] && rm -rf dist || echo "Dist dir clean"
	@pyinstaller --onefile\
                     --icon $(SHOWQR_ICNS)\
                     -s\
                     -c\
                     -F\
                     -p /Library/Python/2.7/site-packages\
                     -p ./venv/lib/python2.7/site-packages\
                     -y\
                     $(SHOWQR_SRC)
	@[ -f $(SHOWQR_FILE) ] &&\
           echo "Successfully created" ||\
           echo "Unsuccessfully created"

test: showqr
	@echo "Testing ShowQR" &&\
         echo "Testing ShowQR" | $(SHOWQR_FILE)

install: showqr $(SHOWQR_WORKFLOW) $(SHOWQR_FILE)
	@echo "Installing ShowQR" &&\
	 sudo cp $(SHOWQR_FILE) /usr/local/bin &&\
	 sudo cp -r $(SHOWQR_WORKFLOW) /Library/Services/ &&\
         echo "Installation successfully accomplished"

all: clean showqr install
