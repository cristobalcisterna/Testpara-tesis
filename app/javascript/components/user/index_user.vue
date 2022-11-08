<template>
    <section class="b-tooltips">
      <div
        class="box"
        style="margin-top: 60px; margin-left: 300px; margin-right: 300px"
      >
        <h1>Usuarios</h1>
  

            <div class="has-text-right">
              <b-button
                label="Añadir Usuario"
                type="is-info"
                icon-left="plus"
                @click="createUser()"
              ></b-button>
            </div>
            <div> 
              <b-modal
                :active="isModalActive"
                aria-modal
                has-modal-card
                :destroy-on-hide="true"
                aria-role="dialog"
                width="100%"
                :can-cancel="canCancel"
              >
                <template>
                  <new-user
                    modal-cancel="true"
                    :modal-header="'Registro de Usuario'"
                    query-type="create"
                    @close="closeModalCreate"
                  ></new-user>
                </template>
              </b-modal>
  

  

  
            </div>
            <div class="column">
              <b-table
                id="table"
                :data="users"
                :paginated="true"
                per-page="8"
                striped
                hoverable
                :pagination-simple="false"
                pagination-active-color="hsl(0, 0%, 0%)"
                pagination-position="bottom"
                default-sort-direction="asc"
                sort-icon="arrow-up"
                aria-next-label="Siguiente"
                aria-previous-label="Anterior"
                aria-page-label="Página"
                aria-current-label="Página actual"
              >
                <b-table-column
                  :visible="false"
                  field="id"
                  label="ID"
                  sortable
                  searchable
                >
  
                  <template v-slot="props">
                    {{ props.row.id }}
                  </template>
                </b-table-column>
  
                
  
                <b-table-column
                  field="full_name"
                  label="Nombre Usuario"
                  sortable
                  searchable
                >
  
                  <template v-slot="props">
                 {{ props.row.full_name }}
             
                  </template>
                </b-table-column>
  
                <b-table-column
                  field="email"
                  label="Correo"
                  sortable
                  searchable
                >
  
                  <template v-slot="props">
                    {{ props.row.email }}
                  </template>
                </b-table-column>
  
                <b-table-column
                  field="rut"
                  label="RUT"
                  sortable
                  searchable>
  
                  <template v-slot="props">
                    {{ props.row.rut }}
                  </template>
                </b-table-column>
  
  
  
  
  
                <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">
                  <div class="columns">
                    <div class="column">
                      <b-tooltip label="Editar" type="is-info">
                        <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editUnit(props.row.id)" />
                      </b-tooltip>
                    </div>
                  </div>
  
  
  
                </b-table-column>
  
  
              </b-table>
            </div>

      </div>
    </section>
  </template>
  
  
  <script>
  import axios from "axios";
  import NewUser from "./new_user.vue";
 
  //import ShowUnit from "./show_unit.vue";
  import exportXlsFile from "export-from-json";
  export default {
    data() {
      return {
        users: [],
        null_units: [],
        canCancel: ["escape"],
        isModalActive: false,
        isModalActiveEdit: false,
        selected: null,
        continue: false,

      };
    },
    components: {
      NewUser,
      //ShowUnit,

    },
    props: ["userId"],
    methods: {
  
      
          async getusers() {
        const response = await axios.get("/users.json");
        this.users = response.data;
      },
  

  

      async createUser() {
        this.isModalActive = true;
      },
      async closeModalCreate() {
        this.isModalActive = false;
      },
  
    },
  
  
    created() {
      this.getusers();

    },
  
  };
  </script>
  
  
  