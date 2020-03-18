<?php
class truncate
{
    const DB_HOST = 'localhost';

    const DB_NAME = 'id12866202_boilerbite';

    const DB_USER = 'id12866202_bb307';

    const DB_PASS = 'bb307';

    private $pdo = null;

    public function __construct()
    {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);

        try {
            $this->pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }
    function __destruct()
    {
        // close the database connection
        $this->pdo = null;
    }
    function truncate(): void
    {
        //Our SQL statement. This will empty / truncate the table "videos"
        $sql = "TRUNCATE TABLE `profiles`
                TRUNCATE TABLE 'goals'";

        //Prepare the SQL query.
        $statement = $this->pdo->prepare($sql);

        //Execute the statement.
        $statement->execute();
    }
}
// Create new object to execute functions
$obj = new truncate();
if (!$obj->truncate()) {
    echo "Table cleared.";
} else {
    echo "Something went worng. Please fix.";
}
