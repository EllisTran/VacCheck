import { useState } from "react";
import AccountFilter from "./AccountFilter";
import BusinessForm from "./BusinessForm";
import HealthProfessionalForm from "./HealthProfessionalForm";
import PersonalUserForm from "./PersonalUserForm";
import { db, auth } from "../../firebase";
import { ReactComponent as Vector2 } from '../styling/Vector2.svg';
import graphic from "../../assets/Graphic.png";
import '../styling/AccountFilter.css';
import { ReactComponent as Vector1 } from '../styling/Vector1.svg';
import { ReactComponent as Vector4 } from '../styling/Vector4.svg';

const SignupPage = (props) => {

  // const history = useHistory();
  const [accountType, setAccountType] = useState("");
  const [emailError, setEmailError] = useState(""); //for error-case(email)
  const [passwordError, setPasswordError] = useState(""); //for error-case(password)Ï
  const clearErrors = () => {
    setEmailError("");
    setPasswordError("");
  };
  const userTypes = {
    isPersonalUser: false,
    isBusiness: false,
    isHealthProfessional: false,
  };

  const selectAccountTypeHandler = (selectedAccountType) => {
    setAccountType(selectedAccountType);
  };

  const createDoc = async (newAccountInfo) => {
    db.collection("users")
      .doc(newAccountInfo.userId)
      .set({
        ...newAccountInfo,
      });
  };

  const personalUserAccountSignupHandler = (personalUserAccountInfo) => {
    createDoc({
      ...personalUserAccountInfo,
      userType: {
        ...userTypes,
        isPersonalUser: true,
      },
    });
  };

  const businessAccountSignupHandler = (businessAccountInfo) => {
    const newAccountInfo = {
      ...businessAccountInfo,
      userType: {
        ...userTypes,
        isBusiness: true,
      },
    };
    createDoc(newAccountInfo);
  };

  const healthProfessionalAccountSignupHandler = (
    healthProfessionalAccountInfo
  ) => {
    const newAccountInfo = {
      ...healthProfessionalAccountInfo,
      userType: {
        ...userTypes,
        isHealthProfessional: true,
      },
    };
    createDoc(newAccountInfo);
  };

  const handleSignup = (newAccountInfo) => {
    console.log(newAccountInfo);
    clearErrors();
    auth
      .createUserWithEmailAndPassword(
        newAccountInfo.email,
        newAccountInfo.password
      )
      .then((data) => {
        delete newAccountInfo["password"];
        if (accountType === "PersonalUser") {
          personalUserAccountSignupHandler({
            ...newAccountInfo,
            userId: data.user.uid
          });
        } else if (accountType === "Business") {
          businessAccountSignupHandler({ ...newAccountInfo, userId: data.user.uid });
        } else if (accountType === "HealthProfessional") {
          healthProfessionalAccountSignupHandler({ ...newAccountInfo, userId: data.user.uid });
        }
        props.history.push("/VacCheckWeb/Login");
      })
      .catch((err) => {
        switch (err.code) {
          case "auth/email-already-in-use":
          case "auth/invalid-email":
            setEmailError(err.message);
            break;
          case "auth/weak-password":
            setPasswordError(err.message);
            break;
          default:
            break;
        }
      });
  };

  return (
    <div className="grid-container">
      <div>
        <img src={graphic} alt="graphic" className="photo" />
      </div>
      <div className="center">
        <div className="logo-container">
          <Vector2 />
          <h1 className="logo">VacCheck</h1>
        </div>
        <div>
          <h3 className="title">Sign Up</h3>
          <AccountFilter
            select={accountType}
            onSelectAccountType={selectAccountTypeHandler}
          />
          {accountType === "PersonalUser" && (
            <PersonalUserForm onSignup={handleSignup} />
          )}
          {accountType === "Business" && (
            <BusinessForm onSignup={handleSignup} />
          )}
          {accountType === "HealthProfessional" && (
            <HealthProfessionalForm
              onSignup={handleSignup}
            />
          )}
        </div>
        

      </div>
      <Vector1 className="Vector1"/>
      <Vector4 className="Vector4"/>
    </div>
  );
};

export default SignupPage;
