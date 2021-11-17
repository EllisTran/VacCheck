import "./App.css";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import { Fragment } from "react";
import MainPage from "../src/components/LandingPage/MainPage";
import Header from "../src/components/LandingPage/Header";
import About from "../src/components/LandingPage/About";
import Demo from "../src/components/LandingPage/Demo";
import ScrollButton from "../src/components/LandingPage/ScrollButton";
import Login from "../src/components/LoginPage/Login";
import UserInput from "../src/components/LoginPage/UserInput";
import SignupPage from "./components/SignupPage/SignupPage";

const App = () => {
  return (
   
    <Router>
  
      <Switch>
        <Route exact path="/" component={MainPage}/>
        <Route path="/userInput" component={UserInput}/>
        <Route path="/SignupPage" component={SignupPage} />
      </Switch>

    </Router>
    

    // <UserInput /> 
  );
};

export default App;

