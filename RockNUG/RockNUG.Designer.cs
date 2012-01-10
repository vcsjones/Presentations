﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Data.EntityClient;
using System.ComponentModel;
using System.Xml.Serialization;
using System.Runtime.Serialization;

[assembly: EdmSchemaAttribute()]
#region EDM Relationship Metadata

[assembly: EdmRelationshipAttribute("RockNUGModel", "FK_Session_ReleaseID__Release_ID", "Release", System.Data.Metadata.Edm.RelationshipMultiplicity.One, typeof(RockNUG.Release), "Session", System.Data.Metadata.Edm.RelationshipMultiplicity.Many, typeof(RockNUG.Session), true)]
[assembly: EdmRelationshipAttribute("RockNUGModel", "FK_Session_SpeakerID__Speaker_ID", "Speaker", System.Data.Metadata.Edm.RelationshipMultiplicity.One, typeof(RockNUG.Speaker), "Session", System.Data.Metadata.Edm.RelationshipMultiplicity.Many, typeof(RockNUG.Session), true)]

#endregion

namespace RockNUG
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class RockNUGEntities : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new RockNUGEntities object using the connection string found in the 'RockNUGEntities' section of the application configuration file.
        /// </summary>
        public RockNUGEntities() : base("name=RockNUGEntities", "RockNUGEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new RockNUGEntities object.
        /// </summary>
        public RockNUGEntities(string connectionString) : base(connectionString, "RockNUGEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new RockNUGEntities object.
        /// </summary>
        public RockNUGEntities(EntityConnection connection) : base(connection, "RockNUGEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        #endregion
    
        #region Partial Methods
    
        partial void OnContextCreated();
    
        #endregion
    
        #region ObjectSet Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        public ObjectSet<Release> Releases
        {
            get
            {
                if ((_Releases == null))
                {
                    _Releases = base.CreateObjectSet<Release>("Releases");
                }
                return _Releases;
            }
        }
        private ObjectSet<Release> _Releases;
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        public ObjectSet<Session> Sessions
        {
            get
            {
                if ((_Sessions == null))
                {
                    _Sessions = base.CreateObjectSet<Session>("Sessions");
                }
                return _Sessions;
            }
        }
        private ObjectSet<Session> _Sessions;
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        public ObjectSet<Speaker> Speakers
        {
            get
            {
                if ((_Speakers == null))
                {
                    _Speakers = base.CreateObjectSet<Speaker>("Speakers");
                }
                return _Speakers;
            }
        }
        private ObjectSet<Speaker> _Speakers;

        #endregion
        #region AddTo Methods
    
        /// <summary>
        /// Deprecated Method for adding a new object to the Releases EntitySet. Consider using the .Add method of the associated ObjectSet&lt;T&gt; property instead.
        /// </summary>
        public void AddToReleases(Release release)
        {
            base.AddObject("Releases", release);
        }
    
        /// <summary>
        /// Deprecated Method for adding a new object to the Sessions EntitySet. Consider using the .Add method of the associated ObjectSet&lt;T&gt; property instead.
        /// </summary>
        public void AddToSessions(Session session)
        {
            base.AddObject("Sessions", session);
        }
    
        /// <summary>
        /// Deprecated Method for adding a new object to the Speakers EntitySet. Consider using the .Add method of the associated ObjectSet&lt;T&gt; property instead.
        /// </summary>
        public void AddToSpeakers(Speaker speaker)
        {
            base.AddObject("Speakers", speaker);
        }

        #endregion
    }
    

    #endregion
    
    #region Entities
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="RockNUGModel", Name="Release")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class Release : EntityObject
    {
        #region Factory Method
    
        /// <summary>
        /// Create a new Release object.
        /// </summary>
        /// <param name="id">Initial value of the ID property.</param>
        /// <param name="version">Initial value of the Version property.</param>
        /// <param name="date">Initial value of the Date property.</param>
        public static Release CreateRelease(global::System.Int32 id, global::System.String version, global::System.DateTime date)
        {
            Release release = new Release();
            release.ID = id;
            release.Version = version;
            release.Date = date;
            return release;
        }

        #endregion
        #region Primitive Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 ID
        {
            get
            {
                return _ID;
            }
            set
            {
                if (_ID != value)
                {
                    OnIDChanging(value);
                    ReportPropertyChanging("ID");
                    _ID = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("ID");
                    OnIDChanged();
                }
            }
        }
        private global::System.Int32 _ID;
        partial void OnIDChanging(global::System.Int32 value);
        partial void OnIDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.String Version
        {
            get
            {
                return _Version;
            }
            set
            {
                OnVersionChanging(value);
                ReportPropertyChanging("Version");
                _Version = StructuralObject.SetValidValue(value, false);
                ReportPropertyChanged("Version");
                OnVersionChanged();
            }
        }
        private global::System.String _Version;
        partial void OnVersionChanging(global::System.String value);
        partial void OnVersionChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.DateTime Date
        {
            get
            {
                return _Date;
            }
            set
            {
                OnDateChanging(value);
                ReportPropertyChanging("Date");
                _Date = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("Date");
                OnDateChanged();
            }
        }
        private global::System.DateTime _Date;
        partial void OnDateChanging(global::System.DateTime value);
        partial void OnDateChanged();

        #endregion
    
        #region Navigation Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [XmlIgnoreAttribute()]
        [SoapIgnoreAttribute()]
        [DataMemberAttribute()]
        [EdmRelationshipNavigationPropertyAttribute("RockNUGModel", "FK_Session_ReleaseID__Release_ID", "Session")]
        public EntityCollection<Session> Sessions
        {
            get
            {
                return ((IEntityWithRelationships)this).RelationshipManager.GetRelatedCollection<Session>("RockNUGModel.FK_Session_ReleaseID__Release_ID", "Session");
            }
            set
            {
                if ((value != null))
                {
                    ((IEntityWithRelationships)this).RelationshipManager.InitializeRelatedCollection<Session>("RockNUGModel.FK_Session_ReleaseID__Release_ID", "Session", value);
                }
            }
        }

        #endregion
    }
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="RockNUGModel", Name="Session")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class Session : EntityObject
    {
        #region Factory Method
    
        /// <summary>
        /// Create a new Session object.
        /// </summary>
        /// <param name="id">Initial value of the ID property.</param>
        /// <param name="speakerID">Initial value of the SpeakerID property.</param>
        /// <param name="releaseID">Initial value of the ReleaseID property.</param>
        /// <param name="begin">Initial value of the Begin property.</param>
        /// <param name="end">Initial value of the End property.</param>
        /// <param name="type">Initial value of the Type property.</param>
        /// <param name="title">Initial value of the Title property.</param>
        public static Session CreateSession(global::System.Int32 id, global::System.Int32 speakerID, global::System.Int32 releaseID, global::System.TimeSpan begin, global::System.TimeSpan end, global::System.Int32 type, global::System.String title)
        {
            Session session = new Session();
            session.ID = id;
            session.SpeakerID = speakerID;
            session.ReleaseID = releaseID;
            session.Begin = begin;
            session.End = end;
            session.Type = type;
            session.Title = title;
            return session;
        }

        #endregion
        #region Primitive Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 ID
        {
            get
            {
                return _ID;
            }
            set
            {
                if (_ID != value)
                {
                    OnIDChanging(value);
                    ReportPropertyChanging("ID");
                    _ID = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("ID");
                    OnIDChanged();
                }
            }
        }
        private global::System.Int32 _ID;
        partial void OnIDChanging(global::System.Int32 value);
        partial void OnIDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 SpeakerID
        {
            get
            {
                return _SpeakerID;
            }
            set
            {
                OnSpeakerIDChanging(value);
                ReportPropertyChanging("SpeakerID");
                _SpeakerID = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("SpeakerID");
                OnSpeakerIDChanged();
            }
        }
        private global::System.Int32 _SpeakerID;
        partial void OnSpeakerIDChanging(global::System.Int32 value);
        partial void OnSpeakerIDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 ReleaseID
        {
            get
            {
                return _ReleaseID;
            }
            set
            {
                OnReleaseIDChanging(value);
                ReportPropertyChanging("ReleaseID");
                _ReleaseID = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("ReleaseID");
                OnReleaseIDChanged();
            }
        }
        private global::System.Int32 _ReleaseID;
        partial void OnReleaseIDChanging(global::System.Int32 value);
        partial void OnReleaseIDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String Abstract
        {
            get
            {
                return _Abstract;
            }
            set
            {
                OnAbstractChanging(value);
                ReportPropertyChanging("Abstract");
                _Abstract = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("Abstract");
                OnAbstractChanged();
            }
        }
        private global::System.String _Abstract;
        partial void OnAbstractChanging(global::System.String value);
        partial void OnAbstractChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.TimeSpan Begin
        {
            get
            {
                return _Begin;
            }
            set
            {
                OnBeginChanging(value);
                ReportPropertyChanging("Begin");
                _Begin = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("Begin");
                OnBeginChanged();
            }
        }
        private global::System.TimeSpan _Begin;
        partial void OnBeginChanging(global::System.TimeSpan value);
        partial void OnBeginChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.TimeSpan End
        {
            get
            {
                return _End;
            }
            set
            {
                OnEndChanging(value);
                ReportPropertyChanging("End");
                _End = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("End");
                OnEndChanged();
            }
        }
        private global::System.TimeSpan _End;
        partial void OnEndChanging(global::System.TimeSpan value);
        partial void OnEndChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 Type
        {
            get
            {
                return _Type;
            }
            set
            {
                OnTypeChanging(value);
                ReportPropertyChanging("Type");
                _Type = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("Type");
                OnTypeChanged();
            }
        }
        private global::System.Int32 _Type;
        partial void OnTypeChanging(global::System.Int32 value);
        partial void OnTypeChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.String Title
        {
            get
            {
                return _Title;
            }
            set
            {
                OnTitleChanging(value);
                ReportPropertyChanging("Title");
                _Title = StructuralObject.SetValidValue(value, false);
                ReportPropertyChanged("Title");
                OnTitleChanged();
            }
        }
        private global::System.String _Title;
        partial void OnTitleChanging(global::System.String value);
        partial void OnTitleChanged();

        #endregion
    
        #region Navigation Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [XmlIgnoreAttribute()]
        [SoapIgnoreAttribute()]
        [DataMemberAttribute()]
        [EdmRelationshipNavigationPropertyAttribute("RockNUGModel", "FK_Session_ReleaseID__Release_ID", "Release")]
        public Release Release
        {
            get
            {
                return ((IEntityWithRelationships)this).RelationshipManager.GetRelatedReference<Release>("RockNUGModel.FK_Session_ReleaseID__Release_ID", "Release").Value;
            }
            set
            {
                ((IEntityWithRelationships)this).RelationshipManager.GetRelatedReference<Release>("RockNUGModel.FK_Session_ReleaseID__Release_ID", "Release").Value = value;
            }
        }
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [BrowsableAttribute(false)]
        [DataMemberAttribute()]
        public EntityReference<Release> ReleaseReference
        {
            get
            {
                return ((IEntityWithRelationships)this).RelationshipManager.GetRelatedReference<Release>("RockNUGModel.FK_Session_ReleaseID__Release_ID", "Release");
            }
            set
            {
                if ((value != null))
                {
                    ((IEntityWithRelationships)this).RelationshipManager.InitializeRelatedReference<Release>("RockNUGModel.FK_Session_ReleaseID__Release_ID", "Release", value);
                }
            }
        }
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [XmlIgnoreAttribute()]
        [SoapIgnoreAttribute()]
        [DataMemberAttribute()]
        [EdmRelationshipNavigationPropertyAttribute("RockNUGModel", "FK_Session_SpeakerID__Speaker_ID", "Speaker")]
        public Speaker Speaker
        {
            get
            {
                return ((IEntityWithRelationships)this).RelationshipManager.GetRelatedReference<Speaker>("RockNUGModel.FK_Session_SpeakerID__Speaker_ID", "Speaker").Value;
            }
            set
            {
                ((IEntityWithRelationships)this).RelationshipManager.GetRelatedReference<Speaker>("RockNUGModel.FK_Session_SpeakerID__Speaker_ID", "Speaker").Value = value;
            }
        }
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [BrowsableAttribute(false)]
        [DataMemberAttribute()]
        public EntityReference<Speaker> SpeakerReference
        {
            get
            {
                return ((IEntityWithRelationships)this).RelationshipManager.GetRelatedReference<Speaker>("RockNUGModel.FK_Session_SpeakerID__Speaker_ID", "Speaker");
            }
            set
            {
                if ((value != null))
                {
                    ((IEntityWithRelationships)this).RelationshipManager.InitializeRelatedReference<Speaker>("RockNUGModel.FK_Session_SpeakerID__Speaker_ID", "Speaker", value);
                }
            }
        }

        #endregion
    }
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="RockNUGModel", Name="Speaker")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class Speaker : EntityObject
    {
        #region Factory Method
    
        /// <summary>
        /// Create a new Speaker object.
        /// </summary>
        /// <param name="id">Initial value of the ID property.</param>
        public static Speaker CreateSpeaker(global::System.Int32 id)
        {
            Speaker speaker = new Speaker();
            speaker.ID = id;
            return speaker;
        }

        #endregion
        #region Primitive Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 ID
        {
            get
            {
                return _ID;
            }
            set
            {
                if (_ID != value)
                {
                    OnIDChanging(value);
                    ReportPropertyChanging("ID");
                    _ID = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("ID");
                    OnIDChanged();
                }
            }
        }
        private global::System.Int32 _ID;
        partial void OnIDChanging(global::System.Int32 value);
        partial void OnIDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String FirstName
        {
            get
            {
                return _FirstName;
            }
            set
            {
                OnFirstNameChanging(value);
                ReportPropertyChanging("FirstName");
                _FirstName = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("FirstName");
                OnFirstNameChanged();
            }
        }
        private global::System.String _FirstName;
        partial void OnFirstNameChanging(global::System.String value);
        partial void OnFirstNameChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String LastName
        {
            get
            {
                return _LastName;
            }
            set
            {
                OnLastNameChanging(value);
                ReportPropertyChanging("LastName");
                _LastName = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("LastName");
                OnLastNameChanged();
            }
        }
        private global::System.String _LastName;
        partial void OnLastNameChanging(global::System.String value);
        partial void OnLastNameChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String Bio
        {
            get
            {
                return _Bio;
            }
            set
            {
                OnBioChanging(value);
                ReportPropertyChanging("Bio");
                _Bio = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("Bio");
                OnBioChanged();
            }
        }
        private global::System.String _Bio;
        partial void OnBioChanging(global::System.String value);
        partial void OnBioChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.Byte[] Mugshot
        {
            get
            {
                return StructuralObject.GetValidValue(_Mugshot);
            }
            set
            {
                OnMugshotChanging(value);
                ReportPropertyChanging("Mugshot");
                _Mugshot = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("Mugshot");
                OnMugshotChanged();
            }
        }
        private global::System.Byte[] _Mugshot;
        partial void OnMugshotChanging(global::System.Byte[] value);
        partial void OnMugshotChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String Website
        {
            get
            {
                return _Website;
            }
            set
            {
                OnWebsiteChanging(value);
                ReportPropertyChanging("Website");
                _Website = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("Website");
                OnWebsiteChanged();
            }
        }
        private global::System.String _Website;
        partial void OnWebsiteChanging(global::System.String value);
        partial void OnWebsiteChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String Twitter
        {
            get
            {
                return _Twitter;
            }
            set
            {
                OnTwitterChanging(value);
                ReportPropertyChanging("Twitter");
                _Twitter = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("Twitter");
                OnTwitterChanged();
            }
        }
        private global::System.String _Twitter;
        partial void OnTwitterChanging(global::System.String value);
        partial void OnTwitterChanged();

        #endregion
    
        #region Navigation Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [XmlIgnoreAttribute()]
        [SoapIgnoreAttribute()]
        [DataMemberAttribute()]
        [EdmRelationshipNavigationPropertyAttribute("RockNUGModel", "FK_Session_SpeakerID__Speaker_ID", "Session")]
        public EntityCollection<Session> Sessions
        {
            get
            {
                return ((IEntityWithRelationships)this).RelationshipManager.GetRelatedCollection<Session>("RockNUGModel.FK_Session_SpeakerID__Speaker_ID", "Session");
            }
            set
            {
                if ((value != null))
                {
                    ((IEntityWithRelationships)this).RelationshipManager.InitializeRelatedCollection<Session>("RockNUGModel.FK_Session_SpeakerID__Speaker_ID", "Session", value);
                }
            }
        }

        #endregion
    }

    #endregion
    
}
