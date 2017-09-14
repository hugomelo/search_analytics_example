import React from 'react'
import ReactDOM from 'react-dom'

export default class Analytics extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      search_analytics: [],
    }
  }

  componentDidMount() {
    this.fetchAnalytics()
  }

  fetchAnalytics() {
    fetch("/api/search_analytics.json")
      .then( (response) => {
        return response.json() })
      .then( (json) => {
        this.setState(json)
      })
    setTimeout(this.fetchAnalytics.bind(this), 3000)
  }

  handleClearStats(e) {
    e.preventDefault()
    fetch("/api/search_analytics/delete_all.json")
      .then( (response) => {
        return response.json() })
      .then( (json) => {
        this.setState(json)
      })
  }

  render() {
    let body = this.state.search_analytics.map((analytic) => {
      return (
        <tr key={analytic.id}>
          <td>
            { analytic.key }
          </td>
          <td>
            { analytic.quantity }
          </td>
        </tr>
      )
    })
    return (
      <div>
        <table className="search_analytics">
          <thead>
            <tr>
              <th>
                Search Phrase
              </th>
              <th>
                Count
              </th>
            </tr>
          </thead>
          <tbody>{ body }</tbody>
        </table>
        <form>
          <button onClick={this.handleClearStats} >Clear Stats</button>
        </form>
      </div>
    )
  }
}
