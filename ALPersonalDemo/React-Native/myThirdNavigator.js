///https://reactnavigation.org/docs/en/app-containers.html

import React, { Component } from "react";
import { View, Text, Button, Image } from "react-native";
import { createStackNavigator, createAppContainer, createBottomTabNavigator } from 'react-navigation'

class LogoTitle extends React.Component {
    render() {
        return (
            <Image
                source={require('./images/baidu_jgylogo3.gif')}
                style={{ width: 117, height: 38 }}
            />
        );
    }
}

class HomeScreen extends React.Component {
    // static navigationOptions = {
    //     //title: 'Home',
    //     headerTitle: <LogoTitle />,
    //     headerRight: (
    //         <Button
    //           onPress={() => alert('This is a button!')}
    //           title="Info"
    //           color="#fff"
    //         />
    //       ),
    //     headerStyle: {
    //         backgroundColor: '#f4511e',
    //     },
    //     headerTintColor: '#fff',
    //     headerTitleStyle: {
    //         fontWeight: 'bold',
    //     },
    // };

    //标题与其屏幕组件的交互
    static navigationOptions = ({ navigation }) => {
        return {
            headerTitle: <LogoTitle />,
            headerRight: (
                <Button
                    onPress={navigation.getParam('increaseCount')}
                    title="+1"
                    color="#fff"
                />
            ),
            headerLeft: (
                <Button
                    onPress={() => navigation.navigate('MyModal')}
                    title="Info"
                    color="#fff"
                />
            ),
        };
    };

    componentWillMount() {
        this.props.navigation.setParams({ increaseCount: this._increaseCount });
    }

    state = {
        count: 0,
    };

    _increaseCount = () => {
        this.setState({ count: this.state.count + 1 });
    };
    render() {
        return (
            <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
                <Text>Home Screen</Text>
                <Text>Count: {this.state.count}</Text>
                <Button
                    title="Go to Details"
                    onPress={() => {
                        /* 1. Navigate to the Details route with params */
                        this.props.navigation.navigate('Details', {
                            itemId: 86,
                            otherParam: 'First Details',
                        });
                    }}
                />
            </View>
        );
    }
    // render() {
    //     return (
    //         <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
    //             <Text>Home Screen</Text>
    //             <Button
    //                 title="Go to Details"
    //                 /* 1. Navigate to the Details route with params */
    //                 onPress={() => this.props.navigation.navigate('Details', {
    //                     itemId: 86,
    //                     otherParam: 'anything you want here',
    //                 })}
    //             />
    //         </View>
    //     );
    // }
}

class DetailsScreen extends Component {
    // static navigationOptions={
    //     title:'Details',
    // };
    // static navigationOptions = ({ navigation }) => {
    //     return {
    //         title: navigation.getParam('otherParam', "A Nested Details Screen"),
    //     };
    // };

    //覆盖共享 navigationOptions
    static navigationOptions = ({ navigation, navigationOptions }) => {
        const { params } = navigation.state;

        return {
            title: params ? params.otherParam : 'A Nested Details Screen',
            /* These values are used instead of the shared configuration! */
            headerStyle: {
                backgroundColor: navigationOptions.headerTintColor,
            },
            headerTintColor: navigationOptions.headerStyle.backgroundColor,
            headerLeft: (
                <Button
                    onPress={navigation.getParam('increaseCount')}
                    title="pop"
                    color="#f4511e"
                />
            ),
        };
    };
    componentWillMount() {
        this.props.navigation.setParams({ increaseCount: this._increaseCount });
    }

    _increaseCount = () => {
        this.props.navigation.goBack()
    };
    render() {
        /* 2. Get the param, provide a fallback value if not available */
        const { navigation } = this.props;
        const itemId = navigation.getParam('itemId', 'NO-ID');
        const otherParam = navigation.getParam('otherParam', 'some default value');
        return (
            <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
                <Text>itemId:{JSON.stringify(itemId)}</Text>
                <Text>otherParam:{JSON.stringify(otherParam)}</Text>
                <Text>Detail Screen</Text>
                <Button
                    title="Go to Details... again"
                    //onPress={() => this.props.navigation.navigate('Details')}
                    onPress={() => this.props.navigation.push('Details', {
                        itemId: Math.floor(Math.random() * 100)
                    })}
                />
                <Button
                    title="Go to Details... again"
                    onPress={() => this.props.navigation.push('Details')}
                />
                <Button
                    title="Go to Home"
                    onPress={() => this.props.navigation.navigate('Home')}
                />
                <Button
                    title="Go back"
                    onPress={() => this.props.navigation.goBack()}
                />

                <Button
                    title="Update the title"
                    onPress={() =>
                        /* 从安装的屏幕组件本身更新活动屏幕的配置 */
                        this.props.navigation.setParams({ otherParam: 'Updated!' })}
                />
            </View>
        );
    }
}

class ModalScreen extends React.Component {
    render() {
        return (
            <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
                <Text style={{ fontSize: 30 }}>This is a modal!</Text>
                <Button
                    onPress={() => this.props.navigation.goBack()}
                    title="Dismiss"
                />
            </View>
        );
    }
}

// const AppNavigator = createStackNavigator({
//     Home: {
//         screen: HomeScreen
//     }
// });

const RootStack = createStackNavigator(
    {
        Home: HomeScreen,
        Details: DetailsScreen,
    },
    {
        initialRouteName: 'Home',
        /* The header config from HomeScreen is now here */
        defaultNavigationOptions: {
            headerStyle: {
                backgroundColor: '#f4511e',
            },
            headerTintColor: '#fff',
            headerTitleStyle: {
                fontWeight: 'bold',
            },
        },
    },
);

//export default createAppContainer(AppNavigator);

//属性navigationOptions可用于配置导航器本身
// const ExampleScreen = View;
// const Home = createStackNavigator(
//     {
//         Feed: ExampleScreen,
//         Profile: ExampleScreen,
//     },
//     {
//         defaultNavigationOptions: {
//             title: 'Home',
//             headerTintColor: '#fff',
//             headerStyle: {
//                 backgroundColor: '#000',
//             },
//         },
//         navigationOptions: {
//             tabBarLabel: 'Home!',
//         },
//     }
// );

const MainStack = createStackNavigator(
    {
        Main: {
            screen: RootStack,
        },
        MyModal: {
            screen: ModalScreen,
        },
    },
    {
        mode: 'modal',
        headerMode: 'none',
    }
);

const Tabs = createBottomTabNavigator({ MainStack });

const AppContainer = createAppContainer(Tabs);

export default class App extends React.Component {
    render() {
        return <AppContainer />
    }
}