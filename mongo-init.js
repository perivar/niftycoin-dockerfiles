print('START MONGO INIT #####################################################');

db = db.getSiblingDB('explorerdb');
db.createUser(
        {
            user: "iquidus",
            pwd: "3xp!0reR",
            roles: [
                {
                    role: "readWrite",
                    db: "explorerdb"
                }
            ]
        }
);
db.createCollection('users');

print('END MONGO INIT #######################################################');
