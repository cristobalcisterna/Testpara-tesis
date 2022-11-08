<template>
  <section class="b-tooltips">
    <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px">
      <h1>Detalle de la Unidad</h1>
      <b-tabs type="is-boxed" position="is-centered">
        <b-tab-item label="Detalle de la Unidad">
          <div class="center">
            <h1>Información de la Unidad</h1>
          </div>
          <div class="box">

            <div v-if="unit" class="columns is-centered">
              <div class="column is-centered">

                <div class="columns">
                  <div class="column">
                    <b-field label="Nombre la unidad:">
                      <b-input v-model=" unit.name_unit " type="text" readonly></b-input>
                    </b-field>
                  </div>
                </div>

                <div class="columns">
                  <div class="column">
                    <b-field label="Numero identificación de la unidad:">
                      <b-input v-model="unit.identification_number_unit" type="text" readonly></b-input>
                    </b-field>
                  </div>
                </div>

                <div class="columns">
                  <div class="column">
                    <b-field label="Monto bruto total invertido en bienes: ">
                      <b-input v-model="total" type="text" readonly></b-input>
                    </b-field>
                  </div>
                </div>

                <div class="columns">
                  <div class="column">
                    <b-field label="Descripción:">
                      <b-input v-model="unit.description_unit" type="text" readonly></b-input>
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

        <b-tab-item label="Personas asociadas a la unidad">
          <div class="center">
            <h1>Personas asociadas a la facultad</h1>
          </div>
          <div class="box">
            <div class="column">
              <b-table :data="managers" :paginated="true" per-page="8" striped hoverable :pagination-simple="false"
                pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up" sort-icon-size="is-small"
                default-sort="inventores.name" aria-next-label="Siguiente" aria-previous-label="Anterior"
                aria-page-label="Página" aria-current-label="Página actual">
                <b-table-column :visible="false" field="id" label="ID" sortable searchable>

                  <template v-slot="props">
                    {{ props.row.id }}
                  </template>
                </b-table-column>

                <b-table-column field="name_duty_manager" label="Nombre de la persona asociada" sortable searchable>

                  <template v-slot="props">
                    <a href="#" @click="Clickshowdutymanager(props.row.id)">{{ props.row.name_duty_manager }}</a>
                  </template>
                </b-table-column>

                <b-table-column field="rut" label="Rut" sortable searchable>

                  <template v-slot="props">
                    {{ props.row.rut }}
                  </template>
                </b-table-column>

                <b-table-column field="unit.name_unit" label="Nombre Unidad" sortable searchable>

                  <template v-slot="props">
                    <a href="#" @click="Clickshowunit(props.row.unit_id)">{{ props.row.unit.name_unit }}</a>

                  </template>
                </b-table-column>

                <b-table-column field="id" width="10" v-slot="props">
                  <b-tooltip label="Ver detalle" type="is-info">
                    <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowdutymanager(props.row.id)" />
                  </b-tooltip>
                </b-table-column>
              </b-table>
            </div>
          </div>
        </b-tab-item>



        <b-tab-item label="Edificios">
          <div class="center">
            <h1>Edificios asociadas a la facultad</h1>
          </div>
          <div class="box">
            <div class="column">
              <b-table :data="buildings_unit" :paginated="true" per-page="8" striped hoverable
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

        <b-tab-item label="Dependencias de la unidad">
          <div class="center">
            <h1>Dependencias de la unidad</h1>
          </div>
          <div class="box">
            <div class="column">
              <b-table :data="offices_unit" :paginated="true" per-page="8" striped hoverable :pagination-simple="false"
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






        <b-tab-item label="Bienes de la unidad">
          <div class="center">
            <h1>Bienes de la unidad</h1>
          </div>
          <div class="box">
            <div class="column">
              <b-table :data="goods" :paginated="true" per-page="8" striped hoverable :pagination-simple="false"
                pagination-position="bottom"  sort-icon="arrow-up" sort-icon-size="is-small"
                aria-next-label="Siguiente" aria-previous-label="Anterior"
                aria-page-label="Página" aria-current-label="Página actual">

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


      </b-tabs>
    </div>


    <a href="/units" style="font-weight: normal;
      font-size: 20px;
      font-family: Arial;
      margin: 10px;
      margin-left: 30px;">Volver
    </a>


  </section>
</template>


<script>
import axios from "axios";
export default {
  name:"show_unit",
  props: ["id",'queryType', 'modalHeader','unitId'],
  data() {
    return {
      total: null,
      unit: null,
      managers: [],
      buildings_unit: [],
      id_buildings_list: [],
      offices_unit: [],
      id_managers_list: [],
      id_offices_list: [],
      id_goods_list: [],
      goods: [],
      goodamounts: [],
      null_activegood: 0,
      props: ["id"],
    };
  },
  methods: {
    async getunits() {
      const response = await axios.get("/units/" + this.unitId + ".json");
      this.unit = response.data;
    },

    async getdutymanagerbyunit() {
      const response = await axios.get(
        "/duty_managers/showdutymanagerunit/" + this.unitId + ".json"
      );
      this.managers = response.data;
      this.id_managers_list = this.managers.map(o => o['id']);
      console.log(this.managers);
    },

            async getgoodbyunit() {
      const response = await axios.get("/goods/showgoodunit/" + this.unitId + ".json");
      this.goods = response.data;
      this.goodamounts = this.goods.map(o => o['amount']);
      this.id_goods_list = this.goods.map(o => o['id']);

      const c = 0;
      this.total = this.goodamounts.reduce((a, b) => a + b,c);
      console.log(this.goods);
   
    },

    async getofficebyunit() {
      const response = await axios.get(
        "/offices/showofficeunit/" + this.unitId + ".json"
      );
      this.offices_unit = response.data;
      this.id_offices_list = this.offices_unit.map(o => o['id']);
      console.log(this.offices_unit);
    },

    async getbuildingbyunit() {
      const response = await axios.get(
        "/buildings/showbuildingunit/" + this.unitId + ".json"
      );
      this.buildings_unit = response.data;
      this.id_buildings_list = this.buildings_unit.map(o => o['id']);
      console.log(this.buildings_unit);
    },

    //Anular Bienes

    confirmGoodNull(item) {
      this.$buefy.dialog.confirm({
        title: "Anular Bien",
        message: "¿Esta seguro de querer anular el bien?.",
        confirmText: "Anular",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.AnulGoodClick(item),
      });
    },

    async AnulGoodClick(item) {
      const response = await axios.put("/goods/" + item + ".json", {
        activegood: this.null_activegood,
      });
      window.location.href = "/units/" + this.unitId;
    },




  //Anular dependencias

    async confirmisempty(item) {
      const response = await axios.get("/goods/showgoodoffice/" + item + ".json");
      this.goods_office = response.data;
      console.log(this.goods_office);
      if (this.goods_office.length == 0) {
        console.log(this.goods_office.length);
        this.confirmGoodNull(item);
        }
        else{
          this.$buefy.dialog.alert({
                    title: 'No se puede anular',
                    type: 'is-danger',
                    message: 'Existen bienes designados en el edificio',
                    confirmText: 'Aceptar'
                })
        }
    },

    confirmOfficeNull(item) {
      this.$buefy.dialog.confirm({
        title: "Anular Dependencia",
        message: "¿Esta seguro de querer anular la Dependencia?.",
        confirmText: "Anular",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.AnulClick(item),
      });
    },


         async AnulClick(item) {
      const response = await axios.put("/offices/" + item + ".json", {
        active_office: this.null_active,
      });
      window.location.href = "/offices";
    },

    async Clickshowgood(item) {
      window.location.href = "/goods/" + item;
    },

    async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },

    async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item);
    },
    async Clickshowbuilding(item) {
      const response = (window.location.href = "/buildings/" + item);
    },
    async Clickshowoffice(item) {
      const response = (window.location.href = "/offices/" + item);
    },

  },
  created() {
    this.getunits();
    this.getdutymanagerbyunit();
    this.getofficebyunit();
    this.getgoodbyunit();
    this.getbuildingbyunit();
    
  },
};
</script>

