* **********************************************************************
* Project:          Media & Motivation
* Created:          20201007
* Last modified:    20201007 by et
* Stata v.16.1

* Note: file directory is set in section 0
* users only need to change the location of their path there
* or their initials
* **********************************************************************
* does
    /*  Installs dependencies (user-written Stata programs)
        in a local directory
    */

* dependencies
	* add required packages/commands
    local ssc_install   "blindschemes.sthlp estout reghdfe ftools"
    local userpack      "StataConfig"

* TO DO:
    *

* **********************************************************************
* 0 - Run config file to establish path names
* **********************************************************************
    /* include "config.do" */

* **********************************************************************
* 1 - Decide if you want to update ado files (otherwise set adoUpdate to 0)
* **********************************************************************
* Set $adoUpdate to 0 to skip updating ado files
        global adoUpdate    1

* **********************************************************************
* 2 - Check if required packages are installed
* **********************************************************************
* Packages from SSC
    foreach package in `ssc_install' {
    	capture : which `package', all
    	if (_rc) {
            capture window stopbox rusure "You are missing some packages." "Do you want to install `package'?"
            if _rc == 0 {
                quietly capture ssc install `package', replace
                if (_rc) {
                    window stopbox rusure `"This package is not on SSC. Do you want to proceed without it?"'
                }
            }
            else {
                exit 199
            }
    	}
    }

* My custom save ado file
	which StataConfig
	if _rc != 0 {
        capture window stopbox rusure "You are missing some packages." "Do you want to install StataConfig?"
        if _rc == 0 {
            qui: net install StataConfig, replace from(https://raw.githubusercontent.com/etjernst/Materials/master/stata/)
        }
        else {
        	exit 199
        }
	}

* Update all ado files
    if $adoUpdate == 1 {
        ado update, update
    }
