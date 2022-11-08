<template>
  <section class="b-tooltips">
    <b-modal :active="isModalActiveEdit" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
      width="100%" :can-cancel="canCancel">
      <template>
        <edit-good :good-id="goodId" :id="selected" :modal-header="'Editar Bien'" query-type="update"
          @close="closeModalEdit"></edit-good>
      </template>
    </b-modal>
    <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px">
      <h1>Detalle de la pesona</h1>
      <b-tabs type="is-boxed" position="is-centered">
        <b-tab-item label="Detalle de la Persona asociada">
          <div class="center">
            <h1>Información de la Persona asociada</h1>
          </div>
          <div class="box">

            <div v-if="duty_manager" class="columns is-centered">
              <div class="column is-centered">

                <div class="columns">
                  <div class="column">
                    <b-field label="Nombre:">
                      <b-input v-model="duty_manager.name_duty_manager" type="text" readonly></b-input>
                    </b-field>
                  </div>
                </div>
                <div class="columns">
                  <div class="column">
                    <b-field label="Rut:">
                      <b-input v-model="duty_manager.rut " type="text" readonly></b-input>
                    </b-field>
                  </div>
                </div>
                <div class="columns">
                  <div class="column">
                      <b-field label="Email">
                          <b-input v-model="duty_manager.email" type="text" readonly></b-input>
                      </b-field>
                    </div>
                  </div>
                <div class="columns">
                  <div class="column">
                    <b-field label="Unidad:">
                      <b-input icon="eye" icon-clickable @icon-click="Clickshowunit(duty_manager.unit_id)"
                        v-model="duty_manager.unit.name_unit " type="text" readonly></b-input>
                    </b-field>
                  </div>
                </div>
              </div>
            </div>
            <div v-else>
              <p>Loading</p>
            </div>
          </div>
        </b-tab-item>






        <b-tab-item label="Bienes a cargo">
          <div class="box">
            <div class="center">
              <h1>Bienes a cargo</h1>
            </div>



            <div class="column">
              <b-table :data="goods" striped hoverable :paginated="true" per-page="8" :pagination-simple="false"
                pagination-position="bottom" sort-icon="arrow-up">
                <b-table-column :visible="false" field="id" label="ID" sortable searchable>
                  <template v-slot="props">
                    {{ props.row.id }}
                  </template>
                </b-table-column>

                <b-table-column field="namegood" label="Nombre" sortable searchable>
                  <template v-slot="props">
                    <a href="#" @click="Clickshowgood(props.row.id)">{{ props.row.namegood }}</a>
                  </template>
                </b-table-column>

                <b-table-column field="identification_number_good" label="N° Inventario" sortable searchable>
                  <template v-slot="props">
                    {{ props.row.identification_number_good }}
                  </template>
                </b-table-column>

                <b-table-column field="duty_manager.name_duty_manager" label="Nombre Persona asociada" sortable
                  searchable>
                  <template v-slot="props">
                    <a href="#" @click="Clickshowdutymanager(props.row.duty_manager_id)">{{
                    props.row.duty_manager.name_duty_manager }}</a>
                  </template>
                </b-table-column>

                <b-table-column field="office.name_building" label="Edificio" sortable searchable>
                  <template v-slot="props">
                    <a href="#" @click="Clickshowbuilding(props.row.office.building_id)">{{
                    props.row.office.name_building }}</a>
                  </template>
                </b-table-column>

                <b-table-column field="office.name_office" label="Dependencia" sortable searchable>
                  <template v-slot="props">
                    <a href="#" @click="Clickshowoffice(props.row.office_id)">{{ props.row.office.name_office }}</a>

                  </template>
                </b-table-column>

                <b-table-column field="id" width="10" v-slot="props" size="is-small">
                  <div class="columns">
                    <div class="column">
                      <b-tooltip label="Ver detalle" type="is-info">
                        <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowgood(props.row.id)" />
                      </b-tooltip>
                    </div>
                    <div class="column">
                    <b-tooltip label="Anular" type="is-info">
                      <b-icon pack="fas" icon="trash" size="is-medium" @click.native="confirmGoodNull(props.row.id)" />
                    </b-tooltip>
                  </div>


                  </div>
                </b-table-column>
              </b-table>

            </div>
          </div>
        </b-tab-item>




        <b-tab-item label="Dependencias a cargo">
          <div class="center">
            <h1>Dependencias a cargo</h1>
          </div>
          <div class="box">
            <div class="column">
              <b-table :data="offices_duty_manager" :paginated="true" per-page="8" striped hoverable :pagination-simple="false"
                pagination-position="bottom"  sort-icon="arrow-up" sort-icon-size="is-small"
                aria-next-label="Siguiente" aria-previous-label="Anterior"
                aria-page-label="Página" aria-current-label="Página actual">
                <b-table-column :visible=false field="id" label="ID" sortable searchable>

                  <template v-slot="props">
                    {{ props.row.id }}
                  </template>
                </b-table-column>

                <b-table-column field="name_office" label="Nombre dependencia" sortable searchable>

                  <template v-slot="props">
                    <a href="#" @click="Clickshowoffice(props.row.id)">{{ props.row.name_office }}</a>
                  </template>
                </b-table-column>

                <b-table-column field="identification_number_office" label="N° Identificación" sortable searchable>

                  <template v-slot="props">
                    {{ props.row.identification_number_office }}
                  </template>
                </b-table-column>

                <b-table-column field="building.name_building" label="Edificio" sortable searchable>

                  <template v-slot="props">
                    <a href="#" @click="Clickshowbuilding(props.row.building_id)">{{ props.row.building.name_building
                    }}</a>

                  </template>
                </b-table-column>

                <b-table-column field="location" label="Ubicación" sortable searchable>

                  <template v-slot="props">
                    {{ props.row.location }}
                  </template>
                </b-table-column>


                <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">

                  <div class="columns">
                    <div class="column">
                      <b-tooltip label="Ver detalle" type="is-info">
                        <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowoffice(props.row.id)" />
                      </b-tooltip>
                    </div>
                    <!--
                    <div class="column">
                      <b-tooltip label="Anular" type="is-info">
                        <b-icon pack="fas" icon="trash" size="is-medium" @click.native="confirmisempty(props.row.id)" />
                      </b-tooltip>
                    </div>
                    <div class="column">
                      <b-tooltip label="Editar" type="is-info">
                        <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editOffice(props.row.id)" />
                      </b-tooltip>
                    </div>
                  -->
                  </div>
                </b-table-column>


              </b-table>
            </div>
          </div>
        </b-tab-item>


        <b-tab-item label="Edificios">
          <div class="center">
            <h1>Edificios a cargo</h1>
          </div>
          <div class="box">
            <div class="column">
              <b-table :data="buildings_duty_manager" :paginated="true" per-page="8" striped hoverable
                :pagination-simple="false" pagination-position="bottom" 
                sort-icon="arrow-up" sort-icon-size="is-small" 
                aria-next-label="Siguiente" aria-previous-label="Anterior" aria-page-label="Página"
                aria-current-label="Página actual">
                <b-table-column :visible=false field="id" label="ID" sortable searchable>

                  <template v-slot="props">
                    {{ props.row.id }}
                  </template>
                </b-table-column>

                <b-table-column field="name_building" label="Nombre Edificio" sortable searchable>

                  <template v-slot="props">
                    <a href="#" @click="Clickshowbuilding(props.row.id)">{{ props.row.name_building }}</a>

                  </template>
                </b-table-column>

                <b-table-column field="identification_number_building" label="N° Identificación" sortable searchable>
                  <template v-slot="props">
                    {{ props.row.identification_number_building }}
                  </template>
                </b-table-column>



                <b-table-column field="unit.name_unit" label="Nombre Unidad" sortable searchable>
                  <template v-slot="props">
                    <a href="#" @click="Clickshowunit(props.row.unit_id)">{{ props.row.unit.name_unit }}</a>
                  </template>
                </b-table-column>

                <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">
                  <div class="columns">
                    <div class="column">
                      <b-tooltip label="Ver detalle" type="is-info">
                        <b-icon pack="fas" icon="eye" size="is-medium"
                          @click.native="Clickshowbuilding(props.row.id)" />
                      </b-tooltip>
                    </div>
                    <!--
                    <div class="column">
                      <b-tooltip label="Anular" type="is-info">
                        <b-icon pack="fas" icon="trash" size="is-medium" @click.native="confirmisempty(props.row.id)" />
                      </b-tooltip>
                    </div>
                    <div class="column">
                      <b-tooltip label="Editar" type="is-info">
                        <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editBuilding(props.row.id)" />
                      </b-tooltip>
                    </div>
                    -->
                  </div>
                </b-table-column>
              </b-table>
            </div>
          </div>
        </b-tab-item>






      </b-tabs>
    </div>
    <a href="/duty_managers" style="font-weight: normal;
  font-size: 20px;
  font-family: Arial;
  margin: 10px;
  margin-left: 30px;">Volver</a>
  </section>
</template>


<script>
import axios from "axios";
//import EditGood from "../good/edit_good.vue";
export default {
  props: ["id",'queryType', 'modalHeader','duty_managerId','goodId'],
   components: {
  //  EditGood,
  },
  data() {
    return {
      duty_manager: null,
      goods: [],
      null_activegood: 0,
      props: ["id"],
      selected: null,
      canCancel: ["escape"],
      null_activegood: 0,
      isModalActive: false,
      isModalActiveEdit: false,
      isModalActiveShow: false,
      offices_duty_manager: [],
      buildings_duty_manager: [],
      
    };
  },
  methods: {
    async getduty_managers() {
      const response = await axios.get(
        "/duty_managers/" + this.duty_managerId + ".json"
      );
      this.duty_manager = response.data;
    },
                async Clickshowbuilding(item) {
      const response = (window.location.href = "/buildings/" + item );
    },
      async Clickshowoffice(item) {
      const response = (window.location.href = "/offices/" + item );
    },
        async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },
         async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item );
    },

    async getgoodbydutymanager() {
      const response = await axios.get("/goods/showgoodutymanager/" + this.duty_managerId + ".json");
      this.goods = response.data;
    
    }, 

    async Clickshowgood(item) {
      const response = (window.location.href = "/goods/" + item);
    },
    async Clickeditgood(item) {
      const response = (window.location.href = "/goods/" + item + "/edit");
    },
    
    async AnulClick(item) {
      const response = await axios.put("/goods/" + item + ".json", {
        activegood: this.null_activegood,
      });
      window.location.href = "/duty_managers/" + this.duty_managerId ;
    },

    confirmGoodNull(item) {
      this.$buefy.dialog.confirm({
        title: 'Anular Bien',
        message: '¿Esta seguro de querer anular el bien?.',
        confirmText: 'Anular',
        cancelText: 'Cancelar',
        type: 'is-danger',
        hasIcon: true,
        onConfirm: () => this.AnulClick(item)
        })
    },
    async editGood(item) {
      this.selected = item;
      this.isModalActiveEdit = true;
    },
    async closeModalEdit() {
      this.isModalActiveEdit = false;
    },


    async getofficebydutymanager() {
      const response = await axios.get("/offices/showofficedutymanager/" + this.duty_managerId + ".json");
      this.offices_duty_manager = response.data;
      console.log(this.offices_duty_manager);
    },

    async getobuildingbydutymanager() {
      const response = await axios.get("/buildings/showbuildingdutymanager/" + this.duty_managerId + ".json");
      this.buildings_duty_manager = response.data;
      console.log(this.buildings_duty_manager);
    },

  },
  created() {
    this.getduty_managers();
    this.getgoodbydutymanager();
    this.getofficebydutymanager();
    this.getobuildingbydutymanager();

  },
};
</script>
