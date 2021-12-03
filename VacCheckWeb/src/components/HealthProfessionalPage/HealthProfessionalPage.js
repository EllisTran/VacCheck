import { useContext, useEffect, useRef, useState } from "react";
import { auth, db } from "../../firebase";
import UserInfoForm from "./UserInfoForm";
import './healthProfessionalPage.css';
import image from "../../assets/Ellis3.jpeg";
import { ReactComponent as Vector2 } from "../styling/Vector2.svg";
import hpGraphic from "../../assets/HPGraphic.png";
const HealthProfessionalPage = (props) => {
    // const { handleLogOuts } = props;
    const childRef = useRef();
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
                ...searchedUser,
                ...newPatientInfo,
            });
        setIsModificationSuccessful(true);
        childRef.current.updateImageUrl();
    }



    return (
        <div className="hpView">
            <div className="headerView">
                <div className="logoView">
                    <Vector2 className="logoText" />
                    <div className="logoText">VacCheck</div>
                </div>
                <div className="headerAfterLogo">
                    <div className="profileView">
                        <img src={image} alt="profImage" className="profileImage"></img>
                        <div style={{ display: "inline", paddingLeft: "10px" }}>
                            <div className="profileText">Ellis Tran</div>
                            <div className="profileSubtext">Health Professional</div>
                        </div>

                    </div>
                    <div className="buttondiv">
                        <button className="headerButton" onClick={props.history.goBack}>Sign Out</button>
                    </div>
                </div>

                {/* <div>Header</div> */}
            </div>
            <div className="mainAndMenu">
                <div className="menu">
                    Home</div>
                <div className="main">
                    <div>
                        <div className="textOnGraphicView">
                            Hi Ellis!
                            <div style={{ fontSize: "23px" }}>Welcome to the Health Professional Portal</div>
                        </div>
                        <img style={{ position: "absolute", height: "15%", width: "100%" }} src={hpGraphic} alt="hpGraphic" />

                    </div>
                    <div className="searchView">
                        <div className="topView">
                            <div className="hospitalName">Mercy Hospital</div>
                            <div className="dateText">December 12th, 2021</div>
                        </div>
                        <div className="emailSearchView">
                            <form onSubmit={submitHandler}>
                                <div>
                                    <input className="emailSearch"
                                        type="email"
                                        value={enteredEmailAddress}
                                        onChange={enteredEmailAddressChangeHandler}
                                        placeholder="Search Email"
                                    />
                                    <div className="searchBtnDiv">
                                        <button className="searchButton" type="submit">Search</button>
                                    </div>
                                </div>
                            </form>
                            {doesPatientExist === true && <UserInfoForm userData={searchedUser} onModifyPatient={handleModifiedPatient} ref={childRef}></UserInfoForm>}
                            {isModificationSuccessful && <div><p>Patient has been modified!</p></div>}
                        </div>
                    </div>

                </div>
            </div>
        </div>
    );
};

export default HealthProfessionalPage;