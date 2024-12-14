# Vue Squad

Vue Squad is a project that allows users to create users, squads, authentication, and tasks. The project uses Ruby on Rails for the backend and Vue.js for the frontend.

## Features

### Main Features

- **User Registration and Authentication**:
  - Users can register with name, email, and password.
  - Authentication via JWT token for security.
  - Login system with credentials validation.

- **Squad Creation and Management**:
  - Users can create and edit squads.
  - Each squad can have multiple members, with permission to add and remove members.

- **Task Creation and Management**:
  - Users can create tasks within squads.
  - Tasks can be assigned to specific squad members.
  - Each task can have a status (e.g., pending, in progress, completed).
  - Ability to edit and delete tasks.

- **Intuitive and Responsive Interface**:
  - The frontend is developed with Vue.js, providing a dynamic and easy-to-navigate interface.
  - The interface is responsive and optimized for mobile devices.

- **Real-Time Notifications**:
  - Notifications for changes in tasks or squads.

- **Task Filtering and Sorting**:
  - Filters by status, creation date, and completion date.
  - Sorting of tasks by date or priority.

### Functional Requirements

- [x] **User Registration**: The system should allow new users to register.
- [x] **User Login**: The system should allow authenticated users to log in using email and password.
- [x] **Squad Management**: The system should allow users to create squads and add members.
- [x] **Task Management**: The system should allow editing, adding, removing, and assigning tasks to squad members.
- [x] **Task Viewing**: The system should allow viewing all tasks within a squad.

### Non-Functional Requirements

- [x] **Security**:
  - [x] Authentication should be done using JWT tokens.
  - [x] Passwords should be encrypted before being stored.
- [ ] **Responsiveness**:
  - [ ] The interface should be responsive and work well on different screen sizes, including mobile devices.
- [x] **Testing**:
  - [x] Backend should be fully tested with rSpec.

## Technologies Used

- **Backend**: Ruby on Rails
- **Frontend**: Vue.js, Vite
- **Database**: SQLite
- **Authentication**: JWT (JSON Web Token)

## How to Run the Project

### Prerequisites:
- Rails 8.0.0
- Ruby 3.3.6
- Node.js

1. Clone the repository:
```bash
   git clone https://github.com/kaufon/VueSquad.git
 ```
2. Install backend dependencies
```bash
cd apps/server && bundle install
```
3. Install front dependencies
```bash
cd apps/web && npm install
```
2. run the project in the root folder
```bash
npm run dev
```
<p align="center">
  Made with ❤️ by Kauan Fonseca 
</p>
