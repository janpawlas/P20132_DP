import {
    Platform,
    ScrollView,
    StyleSheet,
    Text,
    TextInput,
    TouchableOpacity,
    View,
    Alert,
    Button
  } from "react-native";
  import { useState, useEffect } from "react";
  import * as SQLite from "expo-sqlite";
  import { useIsFocused } from '@react-navigation/native';

  const db = SQLite.openDatabase('db')//navázání komunikace

  function Items({ onPressItem }) {
    const [items, setItems] = useState(null);
  
    useEffect(() => { 
      db.transaction((tx) => {
        tx.executeSql(
          `select * from mobile;`,//získání dat z DB
          [],
          (_, { rows: { _array } }) => setItems(_array)
        );
      });
    }, []);
  
    if (items === null || items.length === 0) {
      return null;
    }
  
    return (
      <View style={styles.sectionContainer}>
        {items.map(({ id, value }) => (//užití metody items
          <TouchableOpacity
            key={id}
            onPress={() => onPressItem && onPressItem(id, value)}
            style={{
              borderColor: "#000",
              borderWidth: 1,
              padding: 8,
            }}
          >
            <Text>{id} | {value}</Text>
          </TouchableOpacity>
        ))}
      </View>
    );
  }

export default function HomeScreen({ navigation }) {
    const [forceUpdate, forceUpdateId] = useForceUpdate();

      useEffect(() => {
      db.transaction((tx) => {
        tx.executeSql(
          "create table if not exists mobile (id integer primary key not null, value text);"  //kontrola 
        );
      });
    }, []);
  
    return (
            <View style={styles.flexRow}>
                <ScrollView>
                    <Items
                        key={`${forceUpdateId}`}
                        onPressItem={(id, value) =>
                            Alert.alert(//dialogové okno
                                "Delete",
                                "Přejete si smazat záznam s id " + id + " a hodnotou " + value,
                                [
                                {
                                    text: "Cancel",
                                    onPress: () => console.log("Cancel Pressed"),
                                    style: "cancel"
                                },
                                { text: "OK", onPress: () => 
                                {console.log("OK Pressed")
                                db.transaction(
                                    (tx) => {
                                    tx.executeSql(`delete from mobile where id = ?;`, [id]);
                                    },
                                    null,
                                    forceUpdate
                                )
                                } }
                                ]
                            )
                        }
                        />
                </ScrollView>      
            </View>
    );
  }

  function useForceUpdate() {
    const [value, setValue] = useState(0);
    return [() => setValue(value + 1), value];
  }
  
  const styles = StyleSheet.create({
    container: {
      backgroundColor: "#fff",
      flex: 1,
      paddingTop: 30,
    },
    flexRow: {
      flexDirection: "row",
    },
    listArea: {
      backgroundColor: "#f0f0f0",
      flex: 1,
      paddingTop: 16,
    },
  });