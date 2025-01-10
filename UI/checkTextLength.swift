public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let query = textField.text, query.count >= 2 { //두 글자 이상 텍필에 적고 리턴 시,
        callSearchAPI(query: query)
    } else {
        showCharacterLimitAlert()
    }
    return true
}
