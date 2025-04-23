<template>
  <div class="todo-app">
    <h1 class="title">To-Do List</h1>
    
    <div class="input-container">
      <input 
        v-model="newTask" 
        @keyup.enter="addTask" 
        placeholder="Add a new task..."
        class="task-input"
      />
      <button @click="addTask" class="add-button">Add</button>
    </div>
    
    <div class="filters">
      <button 
        @click="filter = 'all'" 
        :class="{ active: filter === 'all' }"
        class="filter-button"
      >
        All
      </button>
      <button 
        @click="filter = 'active'" 
        :class="{ active: filter === 'active' }"
        class="filter-button"
      >
        Active
      </button>
      <button 
        @click="filter = 'completed'" 
        :class="{ active: filter === 'completed' }"
        class="filter-button"
      >
        Completed
      </button>
    </div>
    
    <ul class="task-list">
      <li v-for="task in filteredTasks" :key="task.id" class="task-item">
        <div class="task-content">
          <input 
            type="checkbox" 
            v-model="task.completed"
            class="task-checkbox"
          />
          <span 
            :class="{ completed: task.completed }"
            class="task-text"
          >
            {{ task.text }}
          </span>
        </div>
        <button @click="removeTask(task.id)" class="delete-button">
          Delete
        </button>
      </li>
    </ul>
    
    <div v-if="tasks.length > 0" class="task-stats">
      {{ activeTaskCount }} tasks left
    </div>
  </div>
</template>

<script>
export default {
  name: 'TodoApp',
  data() {
    return {
      newTask: '',
      tasks: [],
      filter: 'all',
      nextId: 1
    }
  },
  computed: {
    filteredTasks() {
      if (this.filter === 'active') {
        return this.tasks.filter(task => !task.completed)
      } else if (this.filter === 'completed') {
        return this.tasks.filter(task => task.completed)
      }
      return this.tasks
    },
    activeTaskCount() {
      return this.tasks.filter(task => !task.completed).length
    }
  },
  methods: {
    addTask() {
      if (this.newTask.trim()) {
        this.tasks.push({
          id: this.nextId++,
          text: this.newTask,
          completed: false
        })
        this.newTask = ''
      }
    },
    removeTask(id) {
      this.tasks = this.tasks.filter(task => task.id !== id)
    }
  }
}
</script>

<style scoped>
.todo-app {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.title {
  text-align: center;
  color: #333;
  margin-bottom: 20px;
}

.input-container {
  display: flex;
  margin-bottom: 20px;
}

.task-input {
  flex: 1;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ddd;
  border-radius: 4px 0 0 4px;
}

.add-button {
  padding: 10px 20px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 0 4px 4px 0;
  cursor: pointer;
  font-size: 16px;
}

.add-button:hover {
  background-color: #45a049;
}

.filters {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.filter-button {
  margin: 0 5px;
  padding: 8px 12px;
  background-color: #f1f1f1;
  border: 1px solid #ddd;
  border-radius: 4px;
  cursor: pointer;
}

.filter-button.active {
  background-color: #4CAF50;
  color: white;
}

.task-list {
  list-style-type: none;
  padding: 0;
}

.task-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px;
  background-color: #f9f9f9;
  border-radius: 4px;
  margin-bottom: 10px;
}

.task-content {
  display: flex;
  align-items: center;
}

.task-checkbox {
  margin-right: 10px;
}

.task-text {
  font-size: 16px;
}

.task-text.completed {
  text-decoration: line-through;
  color: #888;
}

.delete-button {
  padding: 6px 10px;
  background-color: #f44336;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.delete-button:hover {
  background-color: #d32f2f;
}

.task-stats {
  text-align: center;
  margin-top: 20px;
  color: #666;
}

/* Responsive design */
@media (max-width: 768px) {
  .todo-app {
    padding: 15px;
  }
  
  .title {
    font-size: 24px;
  }
  
  .task-input,
  .add-button {
    font-size: 14px;
    padding: 8px;
  }
  
  .filter-button {
    padding: 6px 10px;
    font-size: 12px;
  }
  
  .task-item {
    padding: 10px;
    flex-direction: column;
    align-items: flex-start;
  }
  
  .task-content {
    margin-bottom: 10px;
    width: 100%;
  }
  
  .delete-button {
    align-self: flex-end;
  }
}

@media (max-width: 480px) {
  .filters {
    flex-direction: column;
    align-items: center;
  }
  
  .filter-button {
    margin: 5px 0;
    width: 100%;
  }
  
  .input-container {
    flex-direction: column;
  }
  
  .task-input {
    border-radius: 4px;
    margin-bottom: 10px;
  }
  
  .add-button {
    border-radius: 4px;
    width: 100%;
  }
}
</style>
