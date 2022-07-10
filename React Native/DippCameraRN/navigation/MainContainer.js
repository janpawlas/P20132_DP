import * as React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import Ionicons from 'react-native-vector-icons/Ionicons';
import { setGlobal } from 'reactn';
import CameraScreen from './screens/CameraScreen';
import GalleryScreen from './screens/GalleryScreen';

const cameraName = "Camera";
const galleryName = "Gallery";

const Tab = createBottomTabNavigator();
setGlobal({
  imgs: []
});
//navigace v aplikaci
export default function MainContainer(){
    return (
      <NavigationContainer>
      <Tab.Navigator
        initialRouteName={cameraName}
        screenOptions={({ route }) => ({
          tabBarIcon: ({ focused, color, size }) => {
            let iconName;
            let rn = route.name;

            if (rn === cameraName) {
              iconName = focused ? 'camera' : 'camera-outline';
            } else if (rn === galleryName) {
              iconName = focused ? 'images' : 'images-outline';
            }
            return <Ionicons name={iconName} size={size} color={color} />;
          },
        })}
        tabBarOptions={{
          activeTintColor: 'darkgreen',
          inactiveTintColor: 'grey',
          labelStyle: { paddingBottom: 10, fontSize: 10 },
          style: { padding: 10, height: 70}
        }}>

        <Tab.Screen name={cameraName} component={CameraScreen} />
        <Tab.Screen name={galleryName} component={GalleryScreen} />
      </Tab.Navigator>
    </NavigationContainer>
  )
}