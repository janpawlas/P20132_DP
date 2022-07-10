using MySqlConnector;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;

namespace DippXamarinDB
{
    class MySql
    {
        string connectionString = "Server=192.168.1.15;User ID=root;Database=test";//nastavení přihlašovacích údajů pro DB
        public ObservableCollection<EntryDB> GetEntriesFromDB()
        {
            ObservableCollection<EntryDB> result = new ObservableCollection<EntryDB>();

            var connection = new MySqlConnection(connectionString); ////navázání spojení
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = "SELECT * FROM mobile";

            var reader = command.ExecuteReader();   //provedění sql příkazu
            while (reader.Read())   //zpracovávání dat
            {
                EntryDB entry = new EntryDB { Id = reader.GetInt32("id"), Name = reader.GetString("name") };    
                result.Add(entry);             
            }
            connection.Close();
           
            return result;
        }

        public void DeleteFromDB(EntryDB entry) ////mazání z DB
        {
            var connection = new MySqlConnection(connectionString);
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = @"DELETE FROM mobile where id = @EntryId";
            command.Parameters.AddWithValue("@EntryId", entry.Id);

            var reader = command.ExecuteReader();
            connection.Close();
        }

        public void AddToDB(string name) //přidávání z DB
        {
            var connection = new MySqlConnection(connectionString);
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = @"INSERT INTO mobile (name) values (@Name)";
            command.Parameters.AddWithValue("@Name",name);

            var reader = command.ExecuteReader();
            connection.Close();
        }
    }
}
