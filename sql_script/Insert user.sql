use boilerbite;
INSERT INTO profiles (
    height,
    userEmail,
    userName,
    weight,
    hashpass,
    age
  )
VALUES
  (
    '160',    #height
    'smiceden', #email
    'twneden',  #username
    '116',    #weight
    sha1('congrats'),  #password
    '17'        #age
  );
  SELECT * FROM profiles;