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

  render() {
    let body = this.state.search_analytics.map((analytic) => {
      return (
        <tr key={analytic.id}>
          <th>
            { analytic.key }
          </th>
          <th>
            { analytic.quantity }
          </th>
        </tr>
      )
    })
    return (
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
    )
  }
}
