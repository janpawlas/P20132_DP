import React, { useState, useEffect, useRef  } from 'react';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import { Camera } from 'expo-camera';
import * as MediaLibrary from 'expo-media-library';
import { FontAwesome, Ionicons,MaterialCommunityIcons } from '@expo/vector-icons';
import { useIsFocused } from '@react-navigation/core';
import { useGlobal } from 'reactn';

export default function CameraScreen() {
  const [imgs, setImgs] = useGlobal('imgs');
  const [hasPermission, setHasPermission] = useState(null);
  const [type, setType] = useState(Camera.Constants.Type.back);
  const isFocused = useIsFocused();
  const ref = useRef(null)
  useEffect(() => {
    (async () => {
      const { status } = await Camera.requestCameraPermissionsAsync();
      setHasPermission(status === 'granted');
    })();
  }, []);

  _takePhoto = async () => { //pořízení fotky
    var startTime = performance.now()

    const photo = await ref.current.takePictureAsync()
    var joined = imgs.concat(photo.uri)
    setImgs(joined);
    const { status } = await MediaLibrary.requestPermissionsAsync()
     if (status === "granted"){
      await MediaLibrary.createAssetAsync(photo.uri);//uložení fotky do zařízení
     }
     var endTime = performance.now()
     var stopwatch = (endTime - startTime) / 1000
	  console.log(`Call to doSomething took ${stopwatch}`)

  }

  if (hasPermission === null) {
    return <View />;
  }
  if (hasPermission === false) {
    return <Text>No access to camera</Text>;
  }
  return (
    isFocused && (
      <View style={{ flex: 1 }}>
              <Camera style={{ flex: 1 }} type={type} ref={ref}>
                 <View style={{flex:1, flexDirection:"row",justifyContent:"center",margin:30}}>
                    <TouchableOpacity
                      style={{
                        alignSelf: 'flex-end',
                        alignItems: 'center',
                        backgroundColor: 'transparent',
                      }}
                      onPress={_takePhoto}
                  >
                  <FontAwesome
                      name="camera"
                      style={{ color: "#fff", fontSize: 40}}
                  />
                </TouchableOpacity>
                </View>
            </Camera>
        </View>
    )
  );
}
