import 'react-native-gesture-handler';
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { Appbar } from 'react-native-paper';
import HomeScreen from './pages/home'
import AddScreen from './pages/add'

const Stack = createStackNavigator();

export default function App() {
  return (//spodní navigace
    <NavigationContainer>
      <Stack.Navigator 
      initialRouteName="Home" 
      screenOptions={{
        header: (props) => <CustomNavigationBar {...props} />,
        }}>
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Add" component={AddScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

function CustomNavigationBar({ navigation, back }) {
  return (//logika vrchního panelu
    <Appbar.Header>
      {back ? <Appbar.BackAction onPress={navigation.goBack} /> : null}
      <Appbar.Content title="SQLite example" />
      {back ? null : <Appbar.Action icon="plus" onPress={() => {navigation.navigate('Add')}} />}
    </Appbar.Header>
  );
}