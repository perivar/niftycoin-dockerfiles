print('START MONGO INIT #####################################################');

//db.auth('admin-user', 'admin-password')

db = db.getSiblingDB('explorerdb');
db.createUser(
        {
            user: "eiquidus",
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
