

const AccountFilter = (props) => {
    const selectChangeHandler = (event) => {
        props.onSelectAccountType(event.target.value);
    }

    return (
        <div>
            <label>Choose your account type</label>
            <select value={props.select} onChange={selectChangeHandler}>
                <option value="" disabled selected></option>
                <option value="PersonalUser">Personal User</option>
                <option value="Business">Business</option>
                <option value="HealthProfessional">Health Professional</option>
            </select>
        </div>
    );
};

export default AccountFilter;