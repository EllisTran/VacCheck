import { useState } from "react";
import AccountFilter from "./AccountFilter";
import BusinessForm from "./BusinessForm";
import HealthProfessionalForm from "./HealthProfessionalForm";
import PersonalUserForm from "./PersonalUserForm";
import {
  collection,
  addDoc,
  doc,
  setDoc,
} from "firebase/firestore";
import db from "../../firebase";

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

  const createDoc = async (newAccountInfo) => {
    const collectionRef = collection(db, "users");
    await addDoc(collectionRef, newAccountInfo).then(function(result){
      const docId = result._key.path.segments[1]
      const docRef = doc(db, "users", docId);
      setDoc(docRef, {...newAccountInfo, userId: docId});
    });

  };

  const personalUserAccountSignupHandler = (personalUserAccountInfo) => {
    const newAccountInfo = {
      ...personalUserAccountInfo,
      userType: {
        ...userTypes,
        isPersonalUser: true,
      },
    };
    createDoc(newAccountInfo);
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
