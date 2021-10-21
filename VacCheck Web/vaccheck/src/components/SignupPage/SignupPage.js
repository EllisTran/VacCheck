import { useState } from "react";
import AccountFilter from "./AccountFilter";
import BusinessForm from "./BusinessForm";
import HealthProfessionalForm from "./HealthProfessionalForm";
import PersonalUserForm from "./PersonalUserForm";
import { db } from "../../firebase";

const SignupPage = () => {
  const [accountType, setAccountType] = useState("");

  const userTypes = {
    isPersonalUser: false,
    isBusiness: false,
    isHealthProfessional: false,
  };

  const selectAccountTypeHandler = (selectedAccountType) => {
    setAccountType(selectedAccountType);
  };

  // Replace her docId with authID
  const createDoc = async (newAccountInfo) => {
    // Give me Auth id here... replace db.collection("users").doc().set.... with db.collection("users").doc(auth_id).set....
    db.collection("users").doc("LA").set({ //instead of LA put auth_id 
      ...newAccountInfo,
      // put userId: auth_id here
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

  return (
    <div>
      <AccountFilter
        select={accountType}
        onSelectAccountType={selectAccountTypeHandler}
      />
      {accountType === "PersonalUser" && (
        <PersonalUserForm onSignup={personalUserAccountSignupHandler} />
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