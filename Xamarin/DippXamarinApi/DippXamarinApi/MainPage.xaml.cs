using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace DippXamarinApi
{
    public partial class MainPage : ContentPage
    {
        BoardGamesViewModel viewModel;
        bool isLoading;
        public MainPage()
        {
            InitializeComponent();
            viewModel = new BoardGamesViewModel();
            BindingContext = viewModel;
            isLoading = false;
        }

       public async void LoadItemsIncrementally(object sender, EventArgs e)
        {
            if (isLoading || viewModel.count == 0)
                return;

            isLoading = true;

            refreshView.IsRefreshing = true;
            await viewModel.onScrollAsync();

            isLoading = false;
            refreshView.IsRefreshing = false;
               
        }

        private async void SearchButtonPressed(object sender, EventArgs e)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            refreshView.IsRefreshing = true;
            await viewModel.onButtonPushAsync(SearchBar.Text);
            refreshView.IsRefreshing = false;
            stopwatch.Stop();
            Console.WriteLine("Time elapsed: {0}", stopwatch.Elapsed);
        }
    }
}
