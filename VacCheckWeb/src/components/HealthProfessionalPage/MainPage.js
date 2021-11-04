import { useContext, useEffect, useState } from "react";
import { AuthContext, useAuth } from "../../contexts/AuthContext";
import { auth, db } from "../../firebase";
import UserInfoForm from "./UserInfoForm";

const MainPage = () => {
    const [currentUser, setCurrentUser] = useState();
    const [enteredEmailAddress, setEnteredEmailAddress] = useState("");
    const [searchedUser, setSearchedUser] = useState();
    const [searchedUserId, setSearchedUserId] = useState("");
    const [doesPatientExist, setDoesPatientExist] = useState();
    const [isModificationSuccessful, setIsModificationSuccessful] = useState(false);

    useEffect(() => {
        auth.onAuthStateChanged((user) => {
            db.collection("users").where('email', '==', user.email).get().then(result => {
                result.docs.forEach(doc => {
                    setCurrentUser(doc.data());
                })
            });
        })
    }, []);

    const enteredEmailAddressChangeHandler = (event) => {
        setEnteredEmailAddress(event.target.value);
    };

    const submitHandler = (event) => {
        event.preventDefault();
        auth.fetchSignInMethodsForEmail(enteredEmailAddress)
        .then(providers => {
            if (providers.length === 0) {
                setSearchedUser(null);
                setDoesPatientExist(false);
                console.log('providers.length === 0');
                console.log(enteredEmailAddress);
                alert("User " + enteredEmailAddress + " does not exist");
            } else {
                auth.onAuthStateChanged((user) => {
                    db.collection("users").where('email', '==', enteredEmailAddress).get().then(result => {
                        result.docs.forEach(doc => {
                            console.log('log searched user');
                            console.log(doc.data());
                            setSearchedUser(doc.data());
                            setSearchedUserId(doc.id);
                            setDoesPatientExist(true);
                        })
                    });
                }) 
            }
            
        });
        setIsModificationSuccessful(false);
        
    };

    const handleModifiedPatient = (newPatientInfo) => {
        db.collection("users")
        .doc(searchedUserId)
        .set({
          ...newPatientInfo,
        });
        setIsModificationSuccessful(true);
    }

    // const handleFinishedRendering = () => {
    //     setDoesPatientExist(false);
    // }

    return (
    <div>
        <div>
            <h1>VacCheck</h1>
            <button onClick={() => auth.signOut()}>Sign Out</button>
        </div>
        <form onSubmit={submitHandler}>
            <div>
                <label>Email</label>
                <input
                type="email"
                value={enteredEmailAddress}
                onChange={enteredEmailAddressChangeHandler}
                />
                <button type="submit">Search</button>
            </div>
        </form>
        {/* <UserInfoForm userData={searchedUser}></UserInfoForm> */}
        {doesPatientExist === true && <UserInfoForm userData={searchedUser} onModifyPatient={handleModifiedPatient}></UserInfoForm>}
        {/* {doesPatientExist === false && <div><p>User does not exist.</p></div>} */}
        {isModificationSuccessful && <div><p>Patient has been modified!</p></div>}
    </div>);
};

export default MainPage;