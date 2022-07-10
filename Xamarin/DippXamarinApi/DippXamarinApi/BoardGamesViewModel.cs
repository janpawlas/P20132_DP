using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace DippXamarinApi
{
    public class BoardGamesViewModel//celková logika aplikace
    {
        public ObservableCollection<Game> games { get; set; }
        RestService _restService;
        public int skip;
        string keyWord;
        public int count;
        bool isLoading;

        public BoardGamesViewModel()///prvotní inicializace
        {
            this.games = new ObservableCollection<Game>();
            _restService = new RestService();
            skip = 0;
            keyWord = "catan";
            count = 0;
            isLoading = false;
        }


        public async Task onButtonPushAsync(string word)//potvrzení vyhledávání
        {
            keyWord = word;
            skip = 0;
            //volání API
            Root root = await _restService.GetBoardGamesAsync(Constants.BoardGameEndPoint + Constants.ClientId + "&" + Constants.Limit + "&" + Constants.Skip + skip + "&name=" + keyWord);
            updateCount(root);
            if (games.Count != 0)
                games.Clear();
            fillCollectionFromList(root.games);
        }

        public async Task onScrollAsync()///načtení dalších dat z api 
        {
            skip = skip + Constants.LimitInt;
            Root root = await _restService.GetBoardGamesAsync(Constants.BoardGameEndPoint + Constants.ClientId + "&" + Constants.Limit + "&" + Constants.Skip + skip + "&name=" + keyWord);
            updateCount(root);
            fillCollectionFromList(root.games);
        }

        private void fillCollectionFromList(List<Game> list)
        {
            foreach(Game game in list)
            {
                this.games.Add(game);
            }
        }

        private void updateCount(Root root)
        {
            if (root.count != null)
            {
                count = Convert.ToInt32(root.count);
            }
            else
            {
                count = 0;
            }
        }

    }
}
