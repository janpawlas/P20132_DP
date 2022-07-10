import React, {useEffect, useState} from 'react';
import { StyleSheet, Text, View, FlatList, SafeAreaView, StatusBar } from 'react-native';
import { SearchBar } from "react-native-elements";
import NewCard from './components/NewCard';

export default function App() {
  const [data, setData] = useState(null);
  const [search, setSearch] =  useState('warcraft');
  const [skip, setSkip] =  useState(0);
  const [limit , setLimit] =  useState(10)
  useEffect(() =>{
   const getData = async () => {  //prvotní načtení
     const resp = await fetch(`https://api.boardgameatlas.com/api/search?name=${search}&client_id=K2lnAg74ff&limit=${limit}&skip=${skip}`);
     const json = await resp.json();
     const data = json.games;
     setData(data);
   }
   getData();
  }, [])
  
  const fetchMoreData = async () => { //načtení další stránky
    setSkip(skip+limit);
    const resp = await fetch(`https://api.boardgameatlas.com/api/search?name=${search}&client_id=K2lnAg74ff&limit=${limit}&skip=${skip}`);
    const json = await resp.json();
    if(data.length < json.count){
      const newData = json.games;
      setData(data => [...data,...newData] );
    }
  }
  
  const searchFunction = async () => { //vyhledávání
    var startTime = performance.now()
    setSkip(0);
      if(search)
      {
        const resp = await fetch(`https://api.boardgameatlas.com/api/search?name=${search}&client_id=K2lnAg74ff&limit=${limit}&skip=${skip}`);
        const json = await resp.json();
        const newData = json.games;
        setData(newData);
    } 
    var endTime = performance.now()
    var stopwatch = (endTime - startTime) / 1000
    console.log(`Call to doSomething took ${stopwatch}`)
  }

  return (
    <SafeAreaView style={styles.container}>
      <SearchBar
        placeholder="Search Here..."
        lightTheme
        round
        value={search}
        onChangeText={(text) => { setSearch(text) }}
        onSubmitEditing={searchFunction}
        autoCorrect={false}
      />
      <FlatList
        data={data}
        keyExtractor={(item, id) => id.toString()}
        renderItem={({item})=> (
          <NewCard item={item}/>
        )}
        onEndReachedThreshold={3.0}
        onEndReached={fetchMoreData}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: StatusBar.currentHeight || 0,
  },
});
