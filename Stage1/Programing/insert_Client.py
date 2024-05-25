# Python script to generate and print 400 INSERT commands

# The decision to divide the commands into 4 groups of 100 was due to plsql program crashing when trying to run 400
# at once.

import random
from datetime import datetime, timedelta


# Generate a random birth date
def generate_random_birth_date(start_date, end_date):
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    return start_date + timedelta(days=random_days)


def main():
    table_name = "Clients"
    columns = ["client_ID", "client_fname", "client_lname", "client_addr", "client_TEL", "client_payment", "birthday"]

    # Data samples:

    # List of 20 first names
    first_names = ["John", "Emma", "Michael", "Olivia", "James", "Sophia", "William", "Ava", "Benjamin", "Isabella",
                   "Elijah", "Mia", "Lucas", "Amelia", "Mason", "Harper", "Ethan", "Evelyn", "Alexander", "Abigail"]

    # List of 20 last names
    last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez",
                  "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore",
                  "Jackson", "Martin"]

    # For generating random date:
    start_date = datetime(1924, 1, 1)
    end_date = datetime(2021, 1, 1)

    for index in range(1, 5):

        # Define the file path
        file_path = f"insert_Client_output{index}.sql"

        # Open the file in write mode and write the SQL commands
        with open(file_path, "w") as sql_file:

            # Generating the INSERT commands
            for client_id in range(1000, 1100):
                v1 = client_id + index * 100  # client_ID
                v2 = random.choice(first_names)  # client_fname
                v3 = random.choice(last_names)  # client_lname
                v4 = random.randint(1, 10)  # client_addr value is a key from City table
                v5 = random.randint(10000, 99999)  # client_TEL
                v6 = random.randint(150, 400)  # client_payment
                v7 = generate_random_birth_date(start_date, end_date).strftime('%d-%m-%Y')  # birthday

                insert_command = f"INSERT INTO {table_name} ({', '.join(columns)})\n" \
                                 f"VALUES ({v1}, '{v2}', '{v3}', {v4}, {v5}, {v6}, to_date('{v7}', 'dd-mm-yyyy'));\n"

                sql_file.write(insert_command + "commit;\n\n")


if __name__ == '__main__':
    main()
