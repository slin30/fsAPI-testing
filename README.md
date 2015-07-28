# fsAPI-testing
Tests for pulling, parsing, and pushing data with the API (both versions)

This is a work in progress.

* figshareAPIProcessing.R: this is a good place to start. Simple example of what the API can provide without having to go
through authentication/account creation. Does require the rfigshare API, so reference InitialInstallInfo.R if needed. This 
script is suitable for actual use.
    + See Outputs/OpenTestID123.txt for the end result
* figshareBrowseParsing.R: this is an in-progress file for more in-depth, potentially batch metadata handling. It does 
require an account and authentication. Again, refer to InitialInstallInfo.R if you run into any issues.