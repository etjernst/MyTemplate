* Note: Users can edit file path to the project in config.do
* All subsequent files are referred to using dynamic, absolute filepaths
* **********************************************************************
* does
    /* This code runs all do-files needed for data work. */

* TO DO:
    *

* **********************************************************************
* 0 - General setup
* **********************************************************************
  include config.do

* Specify Stata version in use
  global stataVersion 16.1    // set Stata version
  version $stataVersion

* Set graph and Stata preferences
  set scheme plotplain

**********************************************************************
* 1 - Run code
***********************************************************************
	include ${scripts}/0_setup.do
* include ${scripts}/1_cleanData.do     /* add .do files here */
