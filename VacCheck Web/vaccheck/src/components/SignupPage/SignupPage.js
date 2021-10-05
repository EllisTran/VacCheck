import { useState } from "react";
import AccountFilter from "./AccountFilter";
import BusinessForm from "./BusinessForm";
import HealthProfessionalForm from "./HealthProfessionalForm";
import PersonalUserForm from "./PersonalUserForm";
import { onSnapshot, collection, addDoc} from "firebase/firestore";
import db from "../../firebase";

const SignupPage = () => {
  const [accountType, setAccountType] = useState("");
  const [accountInfo, setAccountInfo] = useState({});

  const selectAccountTypeHandler = (selectedAccountType) => {
    setAccountType(selectedAccountType);
  };

  const accountSignupHandler = (enteredAccountInfo) => {
    setAccountInfo(enteredAccountInfo);
    createDoc(enteredAccountInfo);
  };

  const createDoc = async (enteredAccountInfo) => {
      const collectionRef = collection(db, "users");
      await addDoc(collectionRef, accountInfo);
  }

  return (
    <div>
      <AccountFilter
        select={accountType}
        onSelectAccountType={selectAccountTypeHandler}
      />
      {accountType === "PersonalUser" && (
        <PersonalUserForm onSignup={accountSignupHandler} />
      )}
      {accountType === "Business" && (
        <BusinessForm onSignup={accountSignupHandler} />
      )}
      {accountType === "HealthProfessional" && (
        <HealthProfessionalForm onSignup={accountSignupHandler} />
      )}
    </div>
  );
};

export default SignupPage;
