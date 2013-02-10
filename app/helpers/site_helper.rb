module SiteHelper

  SUCCESS =              1     # : a success
  ERR_BAD_CREDENTIALS = -1     # : (for login only) cannot find the user/password pair in the database
  ERR_USER_EXISTS     = -2     #: (for add only) trying to add a user that already exists
  ERR_BAD_USERNAME    = -3     #: (for add, or login) invalid user name (only empty string is invalid)
  ERR_BAD_PASSWORD    = -4

end
