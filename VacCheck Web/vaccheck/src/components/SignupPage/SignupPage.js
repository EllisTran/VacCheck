import { useState } from "react";
import AccountFilter from "./AccountFilter";
import BusinessForm from "./BusinessForm";
import HealthProfessionalForm from "./HealthProfessionalForm";
import PersonalUserForm from "./PersonalUserForm";
import { collection, addDoc } from "firebase/firestore";
import db from "../../firebase";

const SignupPage = () => {
  const [accountType, setAccountType] = useState("");

  const userTypes = {
    personalUser: "Personal User",
    business: "Business",
    healthProfessional: "Health Professional",
  };

  const selectAccountTypeHandler = (selectedAccountType) => {
    setAccountType(selectedAccountType);
  };

  const createDoc = async (newAccountInfo) => {
    const collectionRef = collection(db, "users");
    await addDoc(collectionRef, newAccountInfo);
  };

  const personalUserAccountSignupHandler = (personalUserAccountInfo) => {
    const newAccountInfo = {
      ...personalUserAccountInfo,
      userType: userTypes.personalUser,
    };
    console.log(newAccountInfo);
    createDoc(newAccountInfo);
  };

  const businessAccountSignupHandler = (businessAccountInfo) => {
    const newAccountInfo = {
      ...businessAccountInfo,
      userType: userTypes.business,
    };
    console.log(newAccountInfo);
    createDoc(newAccountInfo);
  };

  const healthProfessionalAccountSignupHandler = (
    healthProfessionalAccountInfo
  ) => {
    const newAccountInfo = {
      ...healthProfessionalAccountInfo,
      userType: userTypes.healthProfessional,
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
