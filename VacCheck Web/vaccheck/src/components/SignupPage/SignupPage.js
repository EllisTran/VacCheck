import { useState } from "react";
import AccountFilter from "./AccountFilter";
import BusinessForm from "./BusinessForm";
import HealthProfessionalForm from "./HealthProfessionalForm";
import PersonalUserForm from "./PersonalUserForm";
import { db, auth } from "../../firebase";

const SignupPage = () => {
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
        console.log("User ID :- ", data.user.uid);
        personalUserAccountSignupHandler({
          ...newAccountInfo,
          userId: data.user.uid
        });
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
        }
      });
  };

  return (
    <div>
      <AccountFilter
        select={accountType}
        onSelectAccountType={selectAccountTypeHandler}
      />
      {accountType === "PersonalUser" && (
        <PersonalUserForm onSignup={handleSignup} />
      )}
      {accountType === "Business" && (
        <BusinessForm onSignup={businessAccountSignupHandler} />
      )}
      {accountType === "HealthProfessional" && (
        <HealthProfessionalForm
          onSignup={healthProfessionalAccountSignupHandler}
        />
      )}
    </div>
  );
};

export default SignupPage;
