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
    '175', #height
    'smicjeremy', #email
    'Twnyang', #username
    '160', #weight
    SHA1('congrats'),
    '21' #age
  );
  SELECT * FROM profiles;