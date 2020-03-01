USE boilerbite;
DELIMITER $$

CREATE PROCEDURE ShowProfiles()
BEGIN
  SELECT 
    userID,
    userName,
    userEmail,
    age,
    height,
    weight,
    hashPass
  FROM
    profiles
  ORDER BY userID;
END $$
DELIMITER ;