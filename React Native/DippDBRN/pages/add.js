import React from 'react';
import {View, Text, Button, StyleSheet, TextInput } from 'react-native';
import HomeScreen from './home'
import * as SQLite from "expo-sqlite";

const db = SQLite.openDatabase('db')

export default function AddScreen({ navigation }) {
    const [text, onChangeText] = React.useState('');

    const add = (text) => {
        if (text === null || text === "") {
          return false;
        }
        var startTime = performance.now()
        db.transaction(//příkaz pro přidávání
          (tx) => {
            tx.executeSql("insert into mobile (value) values (?)", [text]);  
          },
          null,
        );

        onChangeText('');
        navigation.push('Home');
        //navigation.goBack();

        var endTime = performance.now()
        var stopwatch = (endTime - startTime) / 1000
      	console.log(`Call to doSomething took ${stopwatch}`)
      };

    return (//formulář pro přidávání
      <View style={style.container}>
        <Text>Zadejte text</Text>
        <TextInput 
            value={text} 
            onChangeText={text => onChangeText(text)}
            style={style.input}
            />
         <Button title='Submit'  onPress={ () => {
             add(text);
         }} />   
      </View>
    );
  }

  const style = StyleSheet.create({
    container: {
      flex: 1,
      alignItems: 'center',
      justifyContent: 'center',
    },
    input: {
        height: 40,
        margin: 12,
        borderWidth: 1,
        padding: 10,
      },
  });