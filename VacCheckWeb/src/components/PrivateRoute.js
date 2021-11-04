import React, { useContext, useState } from "react";
import { Route, Redirect } from "react-router-dom";
import { AuthContext } from "../contexts/AuthContext";

export default function PrivateRoute({ component: Component, ...rest }) {
  const currentUser = useContext(AuthContext);
//   const [currentUser, setCurrentUser] = useState(useAuth());

  return (
    <Route
      {...rest}
      render={props => {
        return currentUser ? <Component {...props} /> : <Redirect to="/login" />
      }}
    ></Route>
  )
}