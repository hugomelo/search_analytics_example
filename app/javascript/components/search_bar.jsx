import React from 'react'
import ReactDOM from 'react-dom'

export default class SearchBar extends React.Component {
  constructor(props) {
    super(props);
    this.handleInputChange = this.handleInputChange.bind(this);
  }

  handleInputChange(e) {
    this.props.onInput(e.target.value);
  }

  render() {
    return (
      <form>
        <input autoFocus onChange={this.handleInputChange} type="text" placeholder="What are you looking for?" />
      </form>
    )
  }
}
