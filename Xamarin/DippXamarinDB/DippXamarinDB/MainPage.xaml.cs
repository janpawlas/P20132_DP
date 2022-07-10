using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace DippXamarinDB
{

    public partial class MainPage : ContentPage
    {
        ObservableCollection<EntryDB> entries = new ObservableCollection<EntryDB>();
        ObservableCollection<EntryDB> Entries { get { return entries; } }
        public MainPage()
        {
            InitializeComponent();
            refreshFromDB();
        }

        private async void EntryView_ItemTappedAsync(object sender, ItemTappedEventArgs e)
        {
            EntryDB entry = e.Item as EntryDB;
            bool answer = await DisplayAlert("Question?", "Bude smazán záznam s id:" + entry.Id + " a hodnotou: " + entry.Name, "Ano", "Zrušit");   //alert
            if (answer)
            {
                MySql mySql = new MySql();
                mySql.DeleteFromDB(entry);
                refreshFromDB();
            }
        }

        private void refreshFromDB()//obnova dat z DB
        {
            MySql mySql = new MySql();
            entries = mySql.GetEntriesFromDB();
            EntryView.ItemsSource = Entries;
        }

        protected override void OnAppearing()
        {
            refreshFromDB();
            base.OnAppearing();
        }

        private void ToolbarItem_Clicked(object sender, EventArgs e)
        {
            Navigation.PushAsync(new FormPage());
        }
    }
}
