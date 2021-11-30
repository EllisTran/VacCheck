import "./App.css";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import MainPage from "../src/components/LandingPage/MainPage";
import LoginPage from "./components/LoginPage/LoginPage";
import SignupPage from "./components/SignupPage/SignupPage";
import HealthProfessionalPage from "./components/HealthProfessionalPage/HealthProfessionalPage";

const App = () => {
  return (
   
    <Router>
  
      <Switch>
        <Route exact path="/VacCheck" component={MainPage}/>
        <Route path="/VacCheck/Login" component={LoginPage}/>
        <Route path="/VacCheck/SignupPage" component={SignupPage} />
        <Route path="/VacCheck/HealthProfessional" component={HealthProfessionalPage}/>
      </Switch>

    </Router>
    

    // <UserInput /> 
  );
};

export default App;

