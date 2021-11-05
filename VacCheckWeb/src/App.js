import "./App.css";
import UserInput from "../src/components/LoginPage/UserInput";
import MainPage from "../src/components/LandingPage/MainPage";
import Header from "../src/components/LandingPage/Header";
import About from "../src/components/LandingPage/About";


const App = () => {

  return (
    <div className="app">
      <Header />
      <MainPage />
      {/* <About /> */}
    </div>
  );
};

export default App;
